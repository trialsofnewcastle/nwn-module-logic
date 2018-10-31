#include "nwnx_redis"
#include "mod_player_event"
#include "rds_player_event"
#include "nwnx_object"

// creature ondisturb
void main()
{
    object oBank = OBJECT_SELF;
    object oPC = GetLastDisturbed();
    string sID   = GetPlayerID(oPC);
    string sBankSerial = NWNX_Object_Serialize(oBank);
    NWNX_Redis_SET("nwserver:players:"+sID+":bank:item",sBankSerial);
}
