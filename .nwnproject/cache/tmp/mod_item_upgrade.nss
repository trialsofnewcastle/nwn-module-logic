#include "mod_webhook"

//// Pass the weapon in question
//int iItemID(object oItem);
//int iItemID(object oItem)
//{
//    int LocalUUID = GetLocalInt(oItem, "uuid");
//
//    // -- blank local uuid
//    if (LocalUUID == "")
//    {
//        // Generate local uuid
//        SendbWebhook("private","No uuid on item", "Item creation");
//        int RedisItemID = NWNX_Redis_GET("nwserver:item:current",UUID);
//
//        NWNX_Redis_INCR("nwserver:item:current",UUID);
//        SetLocalInt(oItem, "uuid", RedisItemID)   
//
//        return RedisItemID;
//    }
//    return LocalUUID;
//}
//
//int iItemIsMeleeWeapon(object oItem);
//int iItemIsMeleeWeapon(object oItem)
//{
//    if (IPGetIsMeleeWeapon(oItem))
//    {
//        return 1;
//    }
//    return 0;
//}
//
//int iItemRangedWeapon(object oItem);
//int iItemRangedWeapon(object oItem)
//{
//    if (GetWeaponRanged(oItem))
//    {
//        return 1;
//    }
//    return 0;
//}