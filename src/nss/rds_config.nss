#include "nwnx_redis"

string GetPlayerID(object oPC);
string GetPlayerID(object oPC)
{
    string sID = GetPCPublicCDKey(oPC, FALSE);
    return sID;
}

string RdsPlayerEdge(object oPC);
string RdsPlayerEdge(object oPC){
    string sEdge = "nwserver:players:"+GetPlayerID(oPC)+":"+GetName(oPC)+":"+GetPCPlayerName(oPC);
    return sEdge;
}

string RdsServerEdge(string sScriptName);
string RdsServerEdge(string sScriptName){
    string sEdge = "nwserver:server:"+sScriptName;
    return sEdge;
}