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
    Item, 
    Ragdoll,
    Lockers,
    Generators,
    SynapseCustomObject,
    OldGrenades,
    Dummies
}

public class ObjectInfo : MonoBehaviour
{
    public ObjectType Type;

    public List<string> CustomAttributes;

    public float Health;
    
    public bool UpdateEveryFrame;

    public float UpdateFrequency;
}
