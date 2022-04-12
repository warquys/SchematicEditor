using System;
using System.Collections.Generic;
using UnityEngine;

#if UNITY_EDITOR
using UnityEditor;
using UnityEditorInternal;
#endif

public enum ObjectType
{
    Shematic,
    Primitive,
    LightSource,
    Target,
    Door,
    Workstation,
    Item
}

public class ObjectInfo : MonoBehaviour
{
    public ObjectType Type;

    [UDictionary.Split(30, 70)]
    public CustomAttributes customAttributes;
    [Serializable]
    public class CustomAttributes : UDictionary<string, string> { }
}
