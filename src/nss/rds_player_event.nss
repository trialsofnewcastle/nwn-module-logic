#include "nwnx_redis"
#include "rds_config"
#include "mod_player_event"

// -- Store some info on login
void SetGenericInformation(object oPC)
{
  // -- Set Redis
  NWNX_Redis_SET(RdsEdge(oPC, "player")+":information:name",GetPCPlayerName(oPC));
  NWNX_Redis_SET(RdsEdge(oPC, "player")+":information:ip",GetPCIPAddress(oPC));
  NWNX_Redis_SET(RdsEdge(oPC, "player")+":information:cdkey",GetPCPublicCDKey(oPC, FALSE));
}

// -- Store heartbeat location data
void SetHeartbeatLocation(object oPC){
  NWNX_Redis_SET(RdsEdge(oPC, "player")+":save:heartbeat:areatag",PCAreaTag(oPC));
  NWNX_Redis_SET(RdsEdge(oPC, "player")+":save:heartbeat:vector",PCVector(oPC));
  NWNX_Redis_SET(RdsEdge(oPC, "player")+":save:heartbeat:facing",PCFacing(oPC));
}

// -- Store savepoint location data
void SetSavepointLocation(object oPC){
  NWNX_Redis_SET(RdsEdge(oPC, "player")+":save:savepoint:areatag",PCAreaTag(oPC));
  NWNX_Redis_SET(RdsEdge(oPC, "player")+":save:savepoint:vector",PCVector(oPC));
  NWNX_Redis_SET(RdsEdge(oPC, "player")+":save:savepoint:facing",PCFacing(oPC));
}

// -- Store reboot location data
void SetRebootLocation(object oPC){
  NWNX_Redis_SET(RdsEdge(oPC, "player")+":save:reboot:facing",PCAreaTag(oPC));
  NWNX_Redis_SET(RdsEdge(oPC, "player")+":save:reboot:vector",PCVector(oPC));
  NWNX_Redis_SET(RdsEdge(oPC, "player")+":save:reboot:facing",PCFacing(oPC));
}