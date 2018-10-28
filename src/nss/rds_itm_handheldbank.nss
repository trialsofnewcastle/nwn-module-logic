#include "nwnx_redis"



int GetIsPlayerBankInArea(object oArea, string sResRef, object oPC);
int GetIsPlayerBankInArea(object oArea, string sResRef, object oPC)
{
    string sID   = GetPlayerID(oPC);
    string sBankResRef = "BANK."+sID; 

    object oObject = GetFirstObjectInArea(oArea);
    while(GetIsObjectValid(oObject))
    {
         // Destroy any objects tagged "DESTROY"
         if(GetTag(oObject) == sBankResRef)
         {
             return true;
         }
         object oObject = GetNextObjectInArea(oArea);
    }
    return false;
}    


void HandHeldBank(object oPC)
{
    string sID   = GetPlayerID(oPC);
    object oArea = GetArea(oPC);

    int nPlayerBankExists =  NWNX_Redis_EXISTS("nwserver:players:"+sID+":bank:item");
    location lBankSpawn = GetAheadLocation(oPC);

    if (GetIsPlayerBankInArea == 0)
    {
        if (nPlayerBankExists == 0){
            // generate creature
            string sBankResRef = "BANK."+sID;
            object oBank = CreateObject(1,"WHATEVERTHEHIDDENBANKCREATUREIS",lBankSpawn,FALSE,sBankResRef);
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
    // Loop all objects in us, an area
    object oArea = oArea;
    object oObject = GetFirstObjectInArea(oArea);
    while(GetIsObjectValid(oObject))
    {
        if(GetIsAPCInArea(oArea) == 0){

            int iIsaBank = GetLocalInt(oObject, "ISABANK");
            if(iIsaBank == "1")
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

// creature ondisturb
void BankOnDisturb()
{
    object oBank = OBJECT_SELF;
    object oPC = GetLastDisturbed();
    string sID   = GetPlayerID(oPC);
    string sBankSerial = NWNX_Object_Serialize(oBank);
    NWNX_Redis_SET("nwserver:players:"+sID+":bank:item",sBankSerial);
}