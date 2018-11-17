#include "nwnx_redis"

#include "mod_player_event"
#include "_log"

string PlayerUUID(object oPC);
string PlayerUUID(object oPC)
{
    if (GetTag(oPC) == ""){  
        object oMod = GetModule();
        
        // confirm we aren't stealing someone elses key.
        int nUuidInProgress = GetLocalInt(oMod,"uuidinprogress");                                                                                         
        if (nUuidInProgress != 1)
        {
            // get prepared uuid
            string sUUID = NWNX_Redis_GET("system:uuid");
            WriteTimestampedLogEntry(sUUID);
            SetTag(oPC, sUUID);
            // delete the key after we get the value set to sUUID
            NWNX_Redis_DEL("system:uuid"); 
            // send out task to generate new uuid via order.
            NWNX_Redis_PUBLISH("input","newuuid");
            SetLocalInt(oMod,"uuidinprogress",1);
            return sUUID;
        }
        else
        {
            return "";
        }
        }
    else{
        string sUUID = GetTag(oPC);
        return sUUID;
    }
}


string GetUuid();
string GetUuid(){
    object oMod = GetModule();

    // get cached uuid
    string sUUID = NWNX_Redis_GET("system:uuid");

    // delete the key after we get the value set to sUUID
    NWNX_Redis_DEL("system:uuid"); 
    // send out task to generate new uuid via order.
    NWNX_Redis_PUBLISH("input","newuuid");
    SetLocalInt(oMod,"uuidinprogress",1);

    return sUUID;
}

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