#include "rds_config"
#include "mod_player_event"

void HhBankCleanup(object oArea, object oPC)
{
    object oObject     = GetFirstObjectInArea(oArea);
    string sUUID       = PlayerUUID(oPC);
    string sBankResRef = "BANK."+sUUID;

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

void main()
{
    object oArea = OBJECT_SELF;
    object oPC = GetExitingObject();

    // -- cleanup handheld bank creature onexit
    HhBankCleanup(oArea, oPC);
}
