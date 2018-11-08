#include "nwnx_events"
#include "nwnx_object"
#include "rds_config"

void main()
{
    object oPC = OBJECT_SELF;
    object oItem = NWNX_Object_StringToObject(NWNX_Events_GetEventData("ITEM_OBJECT_ID"));
    string sUuid = GetLocalString(oItem, "UUID"); 

    string sMessage= "Item used by " + GetName(oPC) + " ("+GetPCPlayerName(oPC)+") in " + GetName(GetArea(oPC));

    NWNX_Redis_SET(RdsServerEdge(oPC)+":tracking:item:"+sUuid,sPCFacing(oPC));
}