#include "nwnx_time"
#include "nwnx_redis"
#include "x0_i0_position"
#include "rds_config"

// -- Store some info on login
void StoreGenericInformation(object oPC)
{
  string sPcName = GetPCPlayerName(oPC);
  string sIP = GetPCIPAddress(oPC);
  string CDKey = GetPlayerID(oPC);

  NWNX_Redis_SET("nwserver:players:"+CDKey+":"+sPcName+":information:name",sPcName);
  NWNX_Redis_SET("nwserver:players:"+CDKey+":"+sPcName+":information:ip",sIP);
  NWNX_Redis_SET("nwserver:players:"+CDKey+":"+sPcName+":information:cdkey",CDKey);
}


// -- Store heartbeat location data
void StoreHeartbeatLocation(object oPC){
  object oArea = GetArea(oPC);
  string sAreaTag = GetTag(oArea);
  string sPcName = GetPCPlayerName(oPC);
  string CDKey = GetPlayerID(oPC);

  // -- Locate where in the area we are
  vector vPosition = GetPosition(oPC);

  // -- Identify the direction we are facing
  float fOrientation = GetFacing(oPC);

  // -- Convert stuff to strings
  string sVector = VectorToString(vPosition);
  string sPcFacing = FloatToString(fOrientation);

  // -- Set Redis
  NWNX_Redis_SET("nwserver:players:"+CDKey+":"+sPcName+":save:heartbeat:areatag",sAreaTag);
  NWNX_Redis_SET("nwserver:players:"+CDKey+":"+sPcName+":save:heartbeat:vector",sVector);
  NWNX_Redis_SET("nwserver:players:"+CDKey+":"+sPcName+":save:heartbeat:facing",sPcFacing);
}

// -- Store savepoint location data
void SetSavepointLocation(object oPC){
  object oArea = GetArea(oPC);
  string sAreaTag = GetTag(oArea);
  string sPcName = GetPCPlayerName(oPC);
  string CDKey = GetPlayerID(oPC);

  // -- Locate where in the area we are
  vector vPosition = GetPosition(oPC);

  // -- Identify the direction we are facing
  float fOrientation = GetFacing(oPC);

  // -- Convert stuff to strings
  string sVector = VectorToString(vPosition);
  string sPcFacing = FloatToString(fOrientation);

  // -- Set Redis
  NWNX_Redis_SET("nwserver:players:"+CDKey+":"+sPcName+":save:savepoint:areatag",sAreaTag);
  NWNX_Redis_SET("nwserver:players:"+CDKey+":"+sPcName+":save:savepoint:vector",sVector);
  NWNX_Redis_SET("nwserver:players:"+CDKey+":"+sPcName+":save:savepoint:facing",sPcFacing);
}

// -- Store reboot location data
void SetRebootLocation(object oPC){
  object oArea = GetArea(oPC);
  string sAreaTag = GetTag(oArea);
  string sPcName = GetPCPlayerName(oPC);
  string CDKey = GetPlayerID(oPC);

  // -- Locate where in the area we are
  vector vPosition = GetPosition(oPC);

  // -- Identify the direction we are facing
  float fOrientation = GetFacing(oPC);

  // -- Convert stuff to strings
  string sVector = VectorToString(vPosition);
  string sPcFacing = FloatToString(fOrientation);

  // -- Set Redis
  NWNX_Redis_SET("nwserver:players:"+CDKey+":"+sPcName+":save:reboot:facing",sAreaTag);
  NWNX_Redis_SET("nwserver:players:"+CDKey+":"+sPcName+":save:reboot:vector",sVector);
  NWNX_Redis_SET("nwserver:players:"+CDKey+":"+sPcName+":save:reboot:facing",sPcFacing);
}
