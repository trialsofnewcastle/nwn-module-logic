#include "nwnx_redis"

// -- return or assign and return the oPC uuid.
string GetUUIDPlayer(object oPC);
string GetUUIDPlayer(object oPC)
{
    // if the user has no uuid set
    if (GetTag(oPC) == ""){  
        object oMod = GetModule();
        
        // confirm we aren't stealing someone elses key.
        int nUuidInProgress = GetLocalInt(oMod,"uuidinprogress"); 

        // if in progress, else return ""                                                                                        
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
            // sets the module variable so we don't end up duplicating anything.
            SetLocalInt(oMod,"uuidinprogress",1);

            return sUUID;
        }
        else
        {
            return "";
        }
        }
    
    // the most used path
    else{
        string sUUID = GetTag(oPC);
        return sUUID;
    }
}

// -- return a uuid unrelated to player
string GetUUID();
string GetUUID(){
    object oMod = GetModule();

    // get cached uuid
    string sUUID = NWNX_Redis_GET("system:uuid");

    // delete the key after we get the value set to sUUID
    NWNX_Redis_DEL("system:uuid"); 
    // send out task to generate new uuid via order.
    NWNX_Redis_PUBLISH("input","newuuid");

    // sets the module variable so we don't end up duplicating anything.
    SetLocalInt(oMod,"uuidinprogress",1);

    return sUUID;
}