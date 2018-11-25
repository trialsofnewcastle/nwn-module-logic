#include "nwnx_events"
#include "nwnx_object"
#include "nwnx_redis"

#include "order_func"

void main()
{
    object oPC = OBJECT_SELF;
    object oItem = NWNX_Object_StringToObject(NWNX_Events_GetEventData("ITEM_OBJECT_ID"));
    string sPlayerUuid = OrderGetUUIDPlayer(oPC);
    string sItemUuid = GetLocalString(oItem, "UUID"); 
    // NWNX_Redis_SET(RdsEdge(oPC,"item")+":"+sItemUuid+":lastusedby",sPlayerUuid);
}