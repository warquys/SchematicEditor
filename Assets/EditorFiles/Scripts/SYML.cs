﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics.CodeAnalysis;
using System.IO;
using System.Linq;
using System.Text;
using JetBrains.Annotations;
using YamlDotNet.Core;
using YamlDotNet.Core.Events;
using YamlDotNet.Serialization;
using YamlDotNet.Serialization.NamingConventions;
using YamlDotNet.Serialization.ObjectGraphVisitors;
using YamlDotNet.Serialization.TypeInspectors;


namespace Config
{
    public class SYML
    {
        private readonly string _path;

        public Dictionary<string, ConfigSection> Sections = new Dictionary<string, ConfigSection>();

        public SYML(string path)
        {
            _path = path;
            if (!File.Exists(path)) File.Create(path).Close();
        }

        public void Load()
        {
            var text = File.ReadAllText(_path, Encoding.UTF8);
            Sections = ParseString(text);
        }

        public T GetOrSetDefault<T>(string section, T defValue) where T : IConfigSection
        {
            if (Sections.ContainsKey(section))
            {
                return Sections[section].LoadAs<T>();
            }

            var cfgs = new ConfigSection(section, "");
            cfgs.Import(defValue);
            Sections[section] = cfgs;
            Store();
            return defValue;
        }

        public object GetOrSetDefaultUnsafe(string section, object obj)
        {
            if (Sections.ContainsKey(section))
            {
                return Sections[section].LoadAsType(obj.GetType());
            }

            var cfgs = new ConfigSection(section, "");
            cfgs.ImportUnsafe(obj);
            Sections[section] = cfgs;
            Store();
            return obj;
        }


        public void Store()
        {
            var text = WriteSections(Sections);
            File.WriteAllText(_path, text, Encoding.UTF8);
        }

        private static Dictionary<string, ConfigSection> ParseString(string str)
        {
            var sections = new Dictionary<string, ConfigSection>();
            var split = str.Split(new[] { "[", "]" }, StringSplitOptions.None);

            for (var i = 1; i < split.Length; i += 2)
            {
                var identifier = split[i];
                var content = split[i + 1];

                var lastBracket = content.Length - 1;
                var firstBracket = 0;
                for (var i1 = 0; i1 < content.Length; i1++)
                    if (content[i1] == '{')
                    {
                        firstBracket = i1;
                        break;
                    }

                for (var i1 = 0; i1 < content.Length; i1++)
                    if (content[i1] == '}')
                        lastBracket = i1;
                content = content.Substring(firstBracket + 1, lastBracket - firstBracket - 1);

                sections.Add(identifier, new ConfigSection(identifier, content));
            }

            return sections;
        }

        [CanBeNull]
        private static string WriteSections(Dictionary<string, ConfigSection> sections)
        {
            var s = "";
            foreach (var value in sections.Values)
            {
                s += value.Serialize();
                s += "\n";
            }

            return s;
        }
    }

    public interface IConfigSection
    {
    }

    public class ConfigSection
    {
        public ConfigSection()
        {
        }

        public ConfigSection(string section, string content)
        {
            Section = section;
            Content = content;
        }

        public string Section { get; set; }
        public string Content { get; set; }

        public T LoadAs<T>() where T : IConfigSection
        {
            try
            {
                var ret = new DeserializerBuilder()
                    .WithNamingConvention(CamelCaseNamingConvention.Instance)
                    .IgnoreUnmatchedProperties()
                    .Build().Deserialize<T>(Content);
                return ret;
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                throw;
            }
        }

        public object LoadAsType(Type type)
        {
            try
            {
                var ret = new DeserializerBuilder()
                    .WithNamingConvention(CamelCaseNamingConvention.Instance)
                    .IgnoreUnmatchedProperties()
                    .Build().Deserialize(Content, type);
                return ret;
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                throw;
            }
        }

        public string Import<T>(T t) where T : IConfigSection
        {
            Content = new SerializerBuilder()
                .WithNamingConvention(CamelCaseNamingConvention.Instance)
                .WithTypeInspector(inner => new CommentGatheringTypeInspector(inner))
                .WithEmissionPhaseObjectGraphVisitor(args => new CommentsObjectGraphVisitor(args.InnerVisitor))
                .Build().Serialize(t);

            return Content;
        }

        public string ImportUnsafe(object obj)
        {
            Content = new SerializerBuilder()
                .WithNamingConvention(CamelCaseNamingConvention.Instance)
                .WithTypeInspector(inner => new CommentGatheringTypeInspector(inner))
                .WithEmissionPhaseObjectGraphVisitor(args => new CommentsObjectGraphVisitor(args.InnerVisitor))
                .Build().Serialize(obj);
            return Content;
        }


        public string Serialize()
        {
            return "[" + Section + "]" + "\n" + Content.Trim() + "\n";
        }
    }

    /**
     * The code bellow is from https://dotnetfiddle.net/8M6iIE
     * Great thanks to Antoine Aubry for providing this awesome
     * code sample, showing how to emit comments in YamlDotNet
     */
    public class CommentGatheringTypeInspector : TypeInspectorSkeleton
    {
        private readonly ITypeInspector _innerTypeDescriptor;

        public CommentGatheringTypeInspector(ITypeInspector innerTypeDescriptor)
        {
            _innerTypeDescriptor = innerTypeDescriptor ?? throw new ArgumentNullException("innerTypeDescriptor");
        }

        public override IEnumerable<IPropertyDescriptor> GetProperties(Type type, object container)
        {
            return _innerTypeDescriptor
                .GetProperties(type, container)
                .Select(d => new CommentsPropertyDescriptor(d));
        }

        private sealed class CommentsPropertyDescriptor : IPropertyDescriptor
        {
            private readonly IPropertyDescriptor _baseDescriptor;

            public CommentsPropertyDescriptor(IPropertyDescriptor baseDescriptor)
            {
                _baseDescriptor = baseDescriptor;
                Name = baseDescriptor.Name;
            }

            public string Name { get; }

            public Type Type => _baseDescriptor.Type;

            public Type TypeOverride
            {
                get => _baseDescriptor.TypeOverride;
                set => _baseDescriptor.TypeOverride = value;
            }

            public int Order { get; set; }

            public ScalarStyle ScalarStyle
            {
                get => _baseDescriptor.ScalarStyle;
                set => _baseDescriptor.ScalarStyle = value;
            }

            public bool CanWrite => _baseDescriptor.CanWrite;

            public void Write(object target, object value)
            {
                _baseDescriptor.Write(target, value);
            }

            public T GetCustomAttribute<T>() where T : Attribute
            {
                return _baseDescriptor.GetCustomAttribute<T>();
            }

            public IObjectDescriptor Read(object target)
            {
                var description = _baseDescriptor.GetCustomAttribute<DescriptionAttribute>();
                return description != null
                    ? new CommentsObjectDescriptor(_baseDescriptor.Read(target), description.Description)
                    : _baseDescriptor.Read(target);
            }
        }
    }

    public sealed class CommentsObjectDescriptor : IObjectDescriptor
    {
        private readonly IObjectDescriptor _innerDescriptor;

        public CommentsObjectDescriptor(IObjectDescriptor innerDescriptor, string comment)
        {
            _innerDescriptor = innerDescriptor;
            Comment = comment;
        }

        public string Comment { get; }

        public object Value => _innerDescriptor.Value;
        public Type Type => _innerDescriptor.Type;
        public Type StaticType => _innerDescriptor.StaticType;
        public ScalarStyle ScalarStyle => _innerDescriptor.ScalarStyle;
    }

    public class CommentsObjectGraphVisitor : ChainedObjectGraphVisitor
    {
        public CommentsObjectGraphVisitor(IObjectGraphVisitor<IEmitter> nextVisitor)
            : base(nextVisitor)
        {
        }

        public override bool EnterMapping(IPropertyDescriptor key, IObjectDescriptor value, IEmitter context)
        {
            if (value is CommentsObjectDescriptor commentsDescriptor && commentsDescriptor.Comment != null)
                context.Emit(new Comment(commentsDescriptor.Comment, false));

            return base.EnterMapping(key, value, context);
        }
    }
}
