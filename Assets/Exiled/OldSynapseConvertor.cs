using Config;
using Newtonsoft.Json;
using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;

public class OldSynapseConvertor : MonoBehaviour
{
    public List<GameObject> GameObjectToConvert = new List<GameObject>();
    public GameObject ChematicRef = null;
    public List<GameObject> PrimitivesRef = new List<GameObject>();
    public List<GameObject> PickupRef = new List<GameObject> ();
    public GameObject LightRef = null;
    public GameObject WorkstationRef = null;

    void Start()
    {
        foreach (var gameObject in GameObjectToConvert)
        {
            Convert(gameObject);
        }
    }

    int numberOfObject = 0;

    void Spawn(string name, SchematicObjectDataList schematic)
    {
        var synSchematic = GameObject.Instantiate(ChematicRef, new Vector3(100, 0, 0) * numberOfObject, new Quaternion(0,0,0,0));
        var schematicInfo = synSchematic.GetComponent<SchematicInfo>();
        synSchematic.name = name;
        schematicInfo.Name = name;
        schematicInfo.ID = schematic.RootObjectId;

        foreach (var block in schematic.Blocks)
        {
            switch (block.BlockType)
            {
                case BlockType.Empty:
                    continue;
                case BlockType.Primitive:
                    {
                        var primitive = (PrimitiveType)Enum.Parse(typeof(PrimitiveType), block.Properties["PrimitiveType"].ToString());
                        var refobj = PrimitivesRef.Find(p => p.GetComponent<Primitive>().PrimitiveType == primitive);
                        var synapseobj = GameObject.Instantiate(refobj, block.Position, Quaternion.Euler(block.Rotation), synSchematic.transform);
                        var synprimitve = synapseobj.GetComponent<Primitive>();

                        if (!ColorUtility.TryParseHtmlString(block.Properties["Color"].ToString(), out var color))
                            color = Color.white;
                        synprimitve.color = color;
                        synapseobj.transform.localScale = block.Scale;
                        synapseobj.name = synapseobj.name.Replace("(Clone)", "");
                    }
                    break;
                case BlockType.Pickup:
                    {
                        var itemtype = (ItemType)Enum.Parse(typeof(ItemType), block.Properties["ItemType"].ToString());
                        var refobj = PickupRef.Find(p => p.GetComponent<Item>().itemType == itemtype);
                        var synapseobj = GameObject.Instantiate(refobj, block.Position, Quaternion.Euler(block.Rotation), synSchematic.transform);
                        var synitem = synapseobj.GetComponent<Item>();
                        bool canBePickedUp = true;
                        if (!block.Properties.TryGetValue("Locked", out _))
                            canBePickedUp = false;
                        synitem.CanBePickedUp = canBePickedUp;
                        synapseobj.transform.localScale = block.Scale;
                        synapseobj.name = synapseobj.name.Replace("(Clone)", "");
                    }
                    break;
                case BlockType.Workstation:
                    {
                        var synapseobj = GameObject.Instantiate(WorkstationRef, block.Position, Quaternion.Euler(block.Rotation), synSchematic.transform);
                        var synworksation = synapseobj.GetComponent<WorkStation>();

                        synapseobj.transform.localScale = block.Scale;
                        synworksation.UpdateEveryFrame = bool.Parse(block.Properties["IsInteractable"].ToString());
                        synapseobj.name = synapseobj.name.Replace("(Clone)", "");
                    }
                    break;
                case BlockType.Light:
                    {
                        var synapseobj = GameObject.Instantiate(LightRef, block.Position, Quaternion.Euler(block.Rotation), synSchematic.transform);
                        var synlight = synapseobj.GetComponent<LightObject>();
                        if (!ColorUtility.TryParseHtmlString(block.Properties["Color"].ToString(), out var color))
                            color = Color.white;
                        synlight.color = color;
                        synlight.intensity = float.Parse(block.Properties["Intensity"].ToString());
                        synlight.range = float.Parse(block.Properties["Range"].ToString());
                        synlight.shadow = bool.Parse(block.Properties["Shadows"].ToString());
                        synapseobj.name = synapseobj.name.Replace("(Clone)", "");
                    }
                    break;
            }
        }
    }

    void Convert(GameObject gameObject)
    {
        var vector = Vector3.forward * 10;
        var ptransfor = gameObject.transform;
        var cheamatic = GameObject.Instantiate(ChematicRef, ptransfor.position + vector, ptransfor.rotation);
        cheamatic.name = gameObject.name;

        foreach (var childe in gameObject.GetComponentsInChildren<Transform>())
        {
            if (childe.tag == "EditorOnly" || childe == transform)
                continue;

            if (childe.TryGetComponent(out SchematicBlock schematicBlock))
            {
                switch (schematicBlock.BlockType)
                {
                    case BlockType.Primitive:
                        {
                            if (childe.TryGetComponent(out PrimitiveComponent primitiveComponent))
                            {
                                var primitive = (PrimitiveType)Enum.Parse(typeof(PrimitiveType), childe.tag);
                                var ctransfor = childe.transform;
                                var refobj = PrimitivesRef.Find(p => p.GetComponent<Primitive>().PrimitiveType == primitive);
                                var synapseobj = GameObject.Instantiate(refobj, ctransfor.position + vector, ctransfor.rotation, cheamatic.transform);
                                var synprimitve = synapseobj.GetComponent<Primitive>();
                                
                                synprimitve.color = primitiveComponent.Color;
                                synapseobj.transform.localScale = primitiveComponent.Collidable ? childe.localScale : childe.localScale * -1f;
                                synapseobj.name = synapseobj.name.Replace("(Clone)", "");
                            }

                            break;
                        }

                    case BlockType.Pickup:
                        {
                            if (childe.TryGetComponent(out PickupComponent pickupComponent))
                            {
                                var itemtype = pickupComponent.ItemType;
                                var ctransfor = childe.transform;
                                var refobj = PickupRef.Find(p => p.GetComponent<Item>().itemType == itemtype);
                                var synapseobj = GameObject.Instantiate(refobj, ctransfor.position + vector, ctransfor.rotation, cheamatic.transform);
                                var synitem = synapseobj.GetComponent<Item>();
                                
                                synitem.CanBePickedUp = pickupComponent.CanBePickedUp;
                                synapseobj.transform.localScale = childe.localScale;
                                synapseobj.name = synapseobj.name.Replace("(Clone)", "");
                            }

                            break;
                        }

                    case BlockType.Workstation:
                        {
                            if (childe.TryGetComponent(out WorkstationComponent workstationComponent))
                            {
                                var ctransfor = childe.transform;
                                var synapseobj = GameObject.Instantiate(WorkstationRef, ctransfor.position + vector, ctransfor.rotation, cheamatic.transform);
                                var synworksation = synapseobj.GetComponent<WorkStation>();

                                ctransfor.localScale = childe.localScale;
                                synworksation.UpdateEveryFrame = workstationComponent.IsInteractable;
                                synapseobj.name = synapseobj.name.Replace("(Clone)", "");
                            }

                            break;
                        }
                }
            }
            else
            {
                if (childe.TryGetComponent(out Light lightComponent))
                {
                    var ctransfor = childe.transform;
                    var synapseobj = GameObject.Instantiate(LightRef, ctransfor.position + vector, ctransfor.rotation, cheamatic.transform);
                    var synlight = synapseobj.GetComponent<LightObject>();
                    synlight.color = lightComponent.color;
                    synlight.intensity = lightComponent.intensity;
                    synlight.range = lightComponent.range;
                    synlight.shadow = lightComponent.shadows != LightShadows.None;
                    synapseobj.name = synapseobj.name.Replace("(Clone)", "");
                }
            }
        }

    }
}
