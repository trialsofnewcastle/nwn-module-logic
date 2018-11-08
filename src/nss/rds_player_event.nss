#include "nwnx_time"
#include "nwnx_redis"
#include "rds_config"
#include "mod_player_event"

// -- Store some info on login
void StoreGenericInformation(object oPC)
{
  // -- Set Redis
  NWNX_Redis_SET(RdsEdge(oPC, "player")+":information:name",GetPCPlayerName(oPC));
  NWNX_Redis_SET(RdsEdge(oPC, "player")+":information:ip",GetPCIPAddress(oPC));
  NWNX_Redis_SET(RdsEdge(oPC, "player")+":information:cdkey",GetPCPublicCDKey(oPC, FALSE));
}

// -- Store heartbeat location data
void StoreHeartbeatLocation(object oPC){
  NWNX_Redis_SET(RdsEdge(oPC, "player")+":save:heartbeat:areatag",sPCAreaTag(oPC));
  NWNX_Redis_SET(RdsEdge(oPC, "player")+":save:heartbeat:vector",sPCVector(oPC));
  NWNX_Redis_SET(RdsEdge(oPC, "player")+":save:heartbeat:facing",sPCFacing(oPC));
}

// -- Store savepoint location data
void SetSavepointLocation(object oPC){
  NWNX_Redis_SET(RdsEdge(oPC, "player")+":save:savepoint:areatag",sPCAreaTag(oPC));
  NWNX_Redis_SET(RdsEdge(oPC, "player")+":save:savepoint:vector",sPCVector(oPC));
  NWNX_Redis_SET(RdsEdge(oPC, "player")+":save:savepoint:facing",sPCFacing(oPC));
}

// -- Store reboot location data
void SetRebootLocation(object oPC){
  NWNX_Redis_SET(RdsEdge(oPC, "player")+":save:reboot:facing",sPCAreaTag(oPC));
  NWNX_Redis_SET(RdsEdge(oPC, "player")+":save:reboot:vector",sPCVector(oPC));
  NWNX_Redis_SET(RdsEdge(oPC, "player")+":save:reboot:facing",sPCFacing(oPC));
}