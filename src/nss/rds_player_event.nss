#include "nwnx_time"
#include "nwnx_redis"
#include "rds_config"
#include "mod_player_event"

// -- Store some info on login
void StoreGenericInformation(object oPC)
{
  // -- Set Redis
  NWNX_Redis_SET(RdsPlayerEdge(oPC)+":information:name",GetPCPlayerName(oPC));
  NWNX_Redis_SET(RdsPlayerEdge(oPC)+":information:ip",GetPCIPAddress(oPC));
  NWNX_Redis_SET(RdsPlayerEdge(oPC)+":information:cdkey",GetPlayerID(oPC));
}

// -- Store heartbeat location data
void StoreHeartbeatLocation(object oPC){
  // -- Set Redis
  NWNX_Redis_SET(RdsPlayerEdge(oPC)+":save:heartbeat:areatag",sPCAreaTag(oPC));
  NWNX_Redis_SET(RdsPlayerEdge(oPC)+":save:heartbeat:vector",sPCVector(oPC));
  NWNX_Redis_SET(RdsPlayerEdge(oPC)+":save:heartbeat:facing",sPCFacing(oPC));
}

// -- Store savepoint location data
void SetSavepointLocation(object oPC){
  // -- Set Redis
  NWNX_Redis_SET(RdsPlayerEdge(oPC)+":save:savepoint:areatag",sPCAreaTag(oPC));
  NWNX_Redis_SET(RdsPlayerEdge(oPC)+":save:savepoint:vector",sPCVector(oPC));
  NWNX_Redis_SET(RdsPlayerEdge(oPC)+":save:savepoint:facing",sPCFacing(oPC));
}
// -- Store reboot location data
void SetRebootLocation(object oPC){
  // -- Set Redis
  NWNX_Redis_SET(RdsPlayerEdge(oPC)+":save:reboot:facing",sPCAreaTag(oPC));
  NWNX_Redis_SET(RdsPlayerEdge(oPC)+":save:reboot:vector",sPCVector(oPC));
  NWNX_Redis_SET(RdsPlayerEdge(oPC)+":save:reboot:facing",sPCFacing(oPC));
}