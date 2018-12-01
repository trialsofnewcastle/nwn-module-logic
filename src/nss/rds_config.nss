#include "order_func"
#include "_log"
#include "mod_player_event"


string RdsEdgePlayer(object oPC, string sType);
string RdsEdgePlayer(object oPC, string sType){
    string Nwserver = GetModuleName();
    string CDKey    = GetPCPublicCDKey(oPC, FALSE);
    string UUID     = OrderGetUUIDPlayer(oPC);

    //////////////////////////////
    // -- Build edge strings -- //
    //////////////////////////////
    // -- Player
    if (sType == "player")
        {
            string sEdge = Nwserver+":player:"+UUID;
            return sEdge;
        } 
    // -- Error
    else
        {
            Log("Something is wrong with this redis edge type: "+ sType,"2");
            return "error";
        }
}

// -- return the strings related to the redis key structure.
string RdsEdgeServer(string sType);
string RdsEdgeServer(string sType){
    string Nwserver = GetModuleName();

    // ---- Build edge strings
    if (sType == "server")
        {
            string sEdge = Nwserver+":server:";
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