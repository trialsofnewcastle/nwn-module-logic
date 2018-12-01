#include "nwnx_redis"
#include "rds_config"
#include "mod_player_event"

// -- get player count
int GetPlayerCount(int SaveToRedis);
int GetPlayerCount(int SaveToRedis){
  int nPCs = 0;
  object oPC = GetFirstPC();
  while (GetIsObjectValid(oPC) == TRUE)
  {
    nPCs = nPCs+1; // nPCs++;
    oPC = GetNextPC();
  }
  if (SaveToRedis == 1){
    string sPlayerCount = IntToString(nPCs);
    NWNX_redis_SET(RdsEdgeServer("server")+":playercount",sPlayerCount);
  }
  return nPCs;
}

// -- Store some info on login
void SetGenericInformation(object oPC)
{
  // -- Only set if we have a uuid
  if (GetTag(oPC) != ""){
    // -- Set Redis
    NWNX_Redis_SET(RdsEdgePlayer(oPC, "player")+":information:name",GetPCPlayerName(oPC));
    NWNX_Redis_SET(RdsEdgePlayer(oPC, "player")+":information:ip",GetPCIPAddress(oPC));
    NWNX_Redis_SET(RdsEdgePlayer(oPC, "player")+":information:cdkey",GetPCPublicCDKey(oPC, FALSE));      
  }
  else{
  }
}

// -- Store heartbeat location data
void SetHeartbeatLocation(object oPC){
  // -- Only set if we have a uuid
  if (GetTag(oPC) != ""){
    // -- Set Redis
    NWNX_Redis_SET(RdsEdgePlayer(oPC, "player")+":save:heartbeat:areatag",PCAreaTag(oPC));
    NWNX_Redis_SET(RdsEdgePlayer(oPC, "player")+":save:heartbeat:vector",PCVector(oPC));
    NWNX_Redis_SET(RdsEdgePlayer(oPC, "player")+":save:heartbeat:facing",PCFacing(oPC));
  }
  else{
  }
}

// -- Store savepoint location data
void SetSavepointLocation(object oPC){
  // -- Only set if we have a uuid
  if (GetTag(oPC) != ""){
    // -- Set Redis
    NWNX_Redis_SET(RdsEdgePlayer(oPC, "player")+":save:savepoint:areatag",PCAreaTag(oPC));
    NWNX_Redis_SET(RdsEdgePlayer(oPC, "player")+":save:savepoint:vector",PCVector(oPC));
    NWNX_Redis_SET(RdsEdgePlayer(oPC, "player")+":save:savepoint:facing",PCFacing(oPC));
  }
  else{
  }
}

// -- Store reboot location data
void SetRebootLocation(object oPC){
  // -- Only set if we have a uuid
  if (GetTag(oPC) != ""){
    // -- Set Redis
    NWNX_Redis_SET(RdsEdgePlayer(oPC, "player")+":save:reboot:facing",PCAreaTag(oPC));
    NWNX_Redis_SET(RdsEdgePlayer(oPC, "player")+":save:reboot:vector",PCVector(oPC));
    NWNX_Redis_SET(RdsEdgePlayer(oPC, "player")+":save:reboot:facing",PCFacing(oPC));
  }
  else{
  }
}