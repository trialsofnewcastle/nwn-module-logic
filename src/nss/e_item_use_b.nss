#include "nwnx_events"
#include "nwnx_object"
#include "rds_config"

void main()
{
    object oPC = OBJECT_SELF;
    object oItem = NWNX_Object_StringToObject(NWNX_Events_GetEventData("ITEM_OBJECT_ID"));
    string sPlayerUuid = PlayerUUID(oPC);
    string sItemUuid = GetLocalString(oItem, "UUID"); 
    NWNX_Redis_SET(RdsEdge(oPC,"item")+":"+sItemUuid+":lastusedby",sPlayerUuid);
}