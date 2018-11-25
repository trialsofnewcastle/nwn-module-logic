#include "nwnx_redis"
#include "order_func"

#include "mod_player_event"
#include "_log"



// -- return the strings related to the redis key structure.
string RdsEdge(object oPC, string sType);
string RdsEdge(object oPC, string sType)
{
    string Nwserver = GetModuleName();
    string CDKey    = GetPCPublicCDKey(oPC, FALSE);
    string UUID     = OrderGetUUIDPlayer(oPC);

    // ---- Build edge strings
    // -- Server
    if (sType == "server")
        {
            string sEdge = Nwserver+":server:";
            return sEdge;           
        }
    // -- Player        
    if (sType == "player")
        {
            string sEdge = Nwserver+":player:"+UUID;
            return sEdge;
        }
    // -- Item
    if (sType == "item")
        {
            string sEdge = Nwserver+":item:";
            return sEdge;
        }    
    // -- Error
    else
        {
            Log("Something is wrong with this redis edge type: "+ sType,"2");
            return "error";
        }
}