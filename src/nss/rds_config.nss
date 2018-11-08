#include "nwnx_redis"

#include "mod_player_event"
#include "rds_config"
#include "log"

string RdsEdge(object oPC, string sType);
string RdsEdge(object oPC, string sType)
{
    // Dot operator assignment
    string Nwserver = GetModuleName();
    string CDKey    = GetPCPublicCDKey(oPC, FALSE);
    string UUID     = PlayerUUID(oPC);

    // Build edge strings
    if (sType == "server")
        {
            string sEdge = Nwserver+":server:";
            return sEdge;           
        }
    if (sType == "player")
        {
            string sEdge = Nwserver+":player:"+UUID;
            return sEdge;
        }
    if (sType == "item")
        {
            string sEdge = Nwserver+":item:";
            return sEdge;
        }    
    else
        {
            Log("Something is wrong with this redis edge type: "+ sType,"2");
            return "error";
        }
}