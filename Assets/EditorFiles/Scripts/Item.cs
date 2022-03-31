using Config;
using UnityEngine;

public class Item : MonoBehaviour
{
    public Config.ItemType itemType = Config.ItemType.None;

    public bool CanBePickedUp = false;
}
