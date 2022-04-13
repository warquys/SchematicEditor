using System;
using System.Collections.Generic;
using UnityEngine;

public class SchematicInfo : MonoBehaviour
{
    public string Name;

    public int ID;

    public List<string> CustomAttributes;

    public void OnValidate()
    {
        transform.rotation = Quaternion.identity;
    }
}

