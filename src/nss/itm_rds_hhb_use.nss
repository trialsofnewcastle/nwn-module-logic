#include "nwnx_redis"
#include "nwnx_object"
#include "rds_player_event"
#include "x0_i0_position"
#include "mod_player_event"


int GetIsPlayerBankInArea(object oArea, string sResRef, object oPC);
int GetIsPlayerBankInArea(object oArea, string sResRef, object oPC)
{
    string sID  = GetPlayerID(oPC);
    string sBankResRef = "system_bank_"+sID;

    object oObject = GetFirstObjectInArea(oArea);
    while(GetIsObjectValid(oObject))
    {
         if(GetTag(oObject) == sBankResRef)
         {
             return 1;
         }
         object oObject = GetNextObjectInArea(oArea);
    }
    return 0;
}


void main()
{
    object oPC = OBJECT_SELF;
    string sID   = GetPlayerID(oPC);
    string sBankResRef = "system_bank_"+sID;
    object oArea = GetArea(oPC);

    int nPlayerBankExists =  NWNX_Redis_EXISTS("nwserver:players:"+sID+":bank:item");
    location lBankSpawn = GetAheadLocation(oPC);

    if (GetIsPlayerBankInArea(oArea, sBankResRef, oPC) == 0)
    {
        if (nPlayerBankExists == 0){
            // generate creature
            int nObjectType = OBJECT_TYPE_CREATURE;
            object oBank = CreateObject(nObjectType,"system_bank_",lBankSpawn,FALSE,sBankResRef);
            SetLocalInt(oBank,"ISBANK",1);
            SetTag(oBank,sBankResRef);

            // after we get it all setup properly.
            // Store initial blank creature.
            NWNX_Object_Serialize(oBank);

            // open oBank inventory
            OpenInventory(oBank,oPC);

        }
        else {
            string sBank = NWNX_Redis_GET("nwserver:players:"+sID+":bank:item");
            object oBank = NWNX_Object_Deserialize(sBank);

            AssignCommand(oBank, ActionJumpToLocation(lBankSpawn));

            // open oBank inventory
            OpenInventory(oBank,oPC);
        }
    }

    // if the Bank creature is already in the area.
    else{
        object oObject = GetFirstObjectInArea(oArea);
        while(GetIsObjectValid(oObject))
        {
             if(GetTag(oObject) == sBankResRef)
             {
                OpenInventory(oObject,oPC);
                return;
             }
             object oObject = GetNextObjectInArea(oArea);
        }
    }


}

// probably on area leave
void HandHeldBankCleanup(object oArea)
{
    object oPC = GetExitingObject();
    object oObject = GetFirstObjectInArea(oArea);
    string sID   = GetPlayerID(oPC);
    string sBankResRef = "BANK."+sID;

    while(GetIsObjectValid(oObject))
    {
        if(GetIsAPCInArea(oArea) == 0){

            int iIsaBank = GetLocalInt(oObject, "ISABANK");
            if(iIsaBank == 1)
            {
                DestroyObject(oObject);
            }
            object oObject = GetNextObjectInArea(oArea);
        }

        else{
            SetLocalInt(oArea,"BANKINAREA",0);
        }
    }
}
