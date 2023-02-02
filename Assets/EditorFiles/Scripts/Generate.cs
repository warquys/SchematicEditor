using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Config;
using System.IO;
using System.Linq;

public class Generate : MonoBehaviour
{
    void Start()
    {
        var schematicGameobjects = GameObject.FindObjectsOfType<SchematicInfo>();

        foreach (var info in schematicGameobjects)
        {
            var schematic = new SynapseSchematic
            {
                Name = info.Name,
                Id = info.ID,
                CustomAttributes = info.CustomAttributes
            };
            Debug.Log("Found Schematic " + info.Name);

            ProcessSynapseObject(info, schematic);

            StoreSyml(schematic);
        }
    }

    void StoreSyml(SynapseSchematic schematic)
    {
        var path = Path.Combine(Application.dataPath, "Schematics");
        var file = Path.Combine(path, schematic.Name + ".syml");
        var syml = new SYML(file);
        var section = new ConfigSection { Section = schematic.Name };
        section.Import(schematic);
        syml.Sections.Add(schematic.Name, section);
        syml.Store();
        Debug.Log($"File build {file}");
    }

    void ProcessSynapseObject(SchematicInfo info, SynapseSchematic schematic)
    {
        foreach (var objectinfo in info.GetComponentsInChildren<ObjectInfo>())
        {
            var child = objectinfo.transform;
            var pos = info.transform.InverseTransformPoint(child.position);
            var rot = info.transform.TransformDirection(child.rotation.eulerAngles);
            var scale = new Vector3(info.transform.localScale.x * child.lossyScale.x, info.transform.localScale.y * child.lossyScale.y, info.transform.localScale.z * child.lossyScale.z);

            switch (objectinfo.Type)
            {

                case ObjectType.Primitive:
                    var prim = child.GetComponent<Primitive>();
                    schematic.Primitives.Add(new SynapseSchematic.PrimitiveConfiguration
                    {
                        Position = pos,
                        Rotation = rot,
                        Scale = scale,
                        Color = prim.color,
                        PrimitiveType = prim.PrimitiveType,
                        Physics = prim.Physics,
                        CustomAttributes = objectinfo.CustomAttributes,
                    });
                    break;

                case ObjectType.LightSource:
                    var light = child.GetComponent<LightObject>();
                    schematic.Lights.Add(new SynapseSchematic.LightSourceConfiguration
                    {
                        Position = pos,
                        Rotation = rot,
                        Scale = scale,
                        Color = light.color,
                        LightIntensity = light.intensity,
                        LightRange = light.range,
                        LightShadows = light.shadow,
                        CustomAttributes = objectinfo.CustomAttributes
                    });
                    break;

                case ObjectType.Workstation:
                    var work = child.GetComponent<WorkStation>();
                    schematic.WorkStations.Add(new SynapseSchematic.SimpleUpdateConfig
                    {
                        Position = pos,
                        Rotation = rot,
                        Scale = scale,
                        UpdateFrequency = objectinfo.UpdateFrequency,
                        Update = objectinfo.UpdateEveryFrame,
                        CustomAttributes = objectinfo.CustomAttributes
                    });
                    break;

                case ObjectType.Target:
                    var target = child.GetComponent<Target>();
                    schematic.Targets.Add(new SynapseSchematic.TargetConfiguration
                    {
                        Position = pos,
                        Rotation = rot,
                        Scale = scale,
                        CustomAttributes = objectinfo.CustomAttributes,
                        TargetType = target.TargetType
                    });
                    break;
                
                case ObjectType.Door:
                    var door = child.GetComponent<Door>();
                    schematic.Doors.Add(new SynapseSchematic.DoorConfiguration
                    {
                        Position = pos,
                        Rotation = rot,
                        Scale = scale,
                        DoorType = door.DoorType,
                        Locked = door.Locked,
                        Open = door.Open,
                        UnDestroyable = door.UnDestroyable,
                        CustomAttributes = objectinfo.CustomAttributes,
                        Health = objectinfo.Health,
                        UpdateFrequency = objectinfo.UpdateFrequency,
                        Update = objectinfo.UpdateEveryFrame,
                    });
                    break;

                case ObjectType.Ragdoll:
                    var ragdoll = child.GetComponent<Ragdoll>();
                    schematic.Ragdolls.Add(new SynapseSchematic.RagdollConfiguration
                    {
                        Position = pos,
                        Rotation = rot,
                        Scale = scale,
                        DamageType = ragdoll.DamageType,
                        Nick = ragdoll.Nick,
                        RoleType = ragdoll.RoleType,
                        CustomAttributes = objectinfo.CustomAttributes,
                    });
                    break;

                case ObjectType.Lockers:
                    var lockers = child.GetComponent<Lockers>();
                    schematic.Lockers.Add(new SynapseSchematic.LockerConfiguration
                    {
                        Position = pos,
                        Rotation = rot,
                        Scale = scale,
                        Chambers = lockers.Chambers.ToList(),
                        DeleteDefaultItems = lockers.DeleteDefaultItems,
                        LockerType = lockers.Type,
                        UpdateFrequency = objectinfo.UpdateFrequency,
                        Update = objectinfo.UpdateEveryFrame,
                        CustomAttributes = objectinfo.CustomAttributes
                    });
                    break;

                case ObjectType.Generators:
                    var generators = child.GetComponent<Generators>();
                    schematic.Generators.Add(new SynapseSchematic.SimpleUpdateConfig
                    {
                        Position = pos,
                        Rotation = rot,
                        Scale = scale,
                        CustomAttributes = objectinfo.CustomAttributes,
                        Update = objectinfo.UpdateEveryFrame,
                        UpdateFrequency = objectinfo.UpdateFrequency
                    });
                    break;

                case ObjectType.SynapseCustomObject:
                    var custom = child.GetComponent<SynapseCustomObject>();
                    schematic.CustomObjects.Add(new SynapseSchematic.CustomObjectConfiguration
                    {
                        Position = pos,
                        Rotation = rot,
                        Scale = scale,
                        ID = custom.ID,
                        CustomAttributes = objectinfo.CustomAttributes
                    });
                    break;

                case ObjectType.Item:
                    var item = child.GetComponent<Item>();
                    schematic.Items.Add(new SynapseSchematic.ItemConfiguration
                    {
                        Position = pos,
                        Rotation = rot,
                        Scale = scale,
                        CanBePickedUp = item.CanBePickedUp,
                        ItemType = item.itemType,
                        Physics = item.Physics,
                        Durabillity = item.Durabillity,
                        CustomAttributes = objectinfo.CustomAttributes,
                    });
                    break;

                case ObjectType.OldGrenades:
                    var oldGrenade = child.GetComponent<OldGrenades>();
                    schematic.OldGrenades.Add(new SynapseSchematic.OldGrenadeConfiguration
                    {
                        Position = pos,
                        Rotation = rot,
                        Scale = scale,
                        IsFlash = oldGrenade.IsFlash,
                        Update = objectinfo.UpdateEveryFrame,
                        UpdateFrequency = objectinfo.UpdateFrequency,
                        CustomAttributes = objectinfo.CustomAttributes
                    });
                    break;

                case ObjectType.Dummies:
                    var dummie = child.GetComponent<Dummie>();
                    schematic.Dummies.Add(new SynapseSchematic.DummyConfiguration
                    {
                        Position = pos,
                        Rotation = rot,
                        Scale = scale,
                        Badge = dummie.Badge,
                        BadgeColor = dummie.BadgeColor,
                        HeldItem = dummie.HeldItem,
                        Name = dummie.Name,
                        Role = dummie.Role,
                        CustomAttributes = objectinfo.CustomAttributes
                    });
                    break;
            }
        }
    }
    
}
