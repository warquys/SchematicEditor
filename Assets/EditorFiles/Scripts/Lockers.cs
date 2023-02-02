using Config;
using System.Collections.Generic;
using UnityEngine;

internal class Lockers : MonoBehaviour
{
    public SynapseSchematic.LockerConfiguration.LockerChamber[] Chambers;
    
    public LockerType Type;

    public bool DeleteDefaultItems;
}