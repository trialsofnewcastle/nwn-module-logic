//#include "nwnx_redis"
//#include "nwnx_object"
//#include "rds_player_event"
//#include "x0_i0_position"
//#include "mod_player_event"
//
//
//int GetIsPlayerBankInArea(object oArea, string sResRef, object oPC);
//int GetIsPlayerBankInArea(object oArea, string sResRef, object oPC)
//{
//    string sUuid  = PlayerUUID(oPC);
//    string sBankResRef = "system_bank_"+sUuid;
//
//    object oObject = GetFirstObjectInArea(oArea);
//    while(GetIsObjectValid(oObject))
//    {
//         if(GetTag(oObject) == sBankResRef)
//         {
//             return 1;
//         }
//         object oObject = GetNextObjectInArea(oArea);
//    }
//    return 0;
//}


//void main()
//{
//    object oPC = OBJECT_SELF;
//    string sUuid   = PlayerUUID(oPC);
//    string sBankResRef = "system_bank_"+sUuid;
//    object oArea = GetArea(oPC);
//
//    int nPlayerBankExists =  NWNX_Redis_EXISTS(RdsEdge(oPC, "player")+":bank:item");
//    location lBankSpawn = GetAheadLocation(oPC);
//
//    // Check area for bank creature first
//    if (GetIsPlayerBankInArea(oArea, sBankResRef, oPC) == 0)
//    {
//        // If this is the first time they are using the item
//        if (nPlayerBankExists == 0){
//            // generate creature
//            int nObjectType = OBJECT_TYPE_CREATURE;
//            object oBank = CreateObject(nObjectType,"system_bank_",lBankSpawn,FALSE,sBankResRef);
//            SetLocalInt(oBank,"ISBANK",1);
//            SetTag(oBank,sBankResRef);
//
//            // Store initial blank creature.
//            NWNX_Object_Serialize(oBank);
//
//            // open oBank inventory
//            OpenInventory(oBank,oPC);
//
//        }
//        // if user has bank setup already
//        else {
//            string sBank = NWNX_Redis_GET(RdsEdge(oPC, "player")+":bank:item");
//            object oBank = NWNX_Object_Deserialize(sBank);
//
//            AssignCommand(oBank, ActionJumpToLocation(lBankSpawn));
//
//            // open oBank inventory
//            OpenInventory(oBank,oPC);
//        }
//    }
//
//    // if the Bank creature is already in the area.
//    else{
//        object oObject = GetFirstObjectInArea(oArea);
//        while(GetIsObjectValid(oObject))
//        {
//             if(GetTag(oObject) == sBankResRef)
//             {
//                OpenInventory(oObject,oPC);
//                return;
//             }
//             object oObject = GetNextObjectInArea(oArea);
//        }
//    }
//}
//