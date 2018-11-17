#include "rds_player_event"
#include "nwnx_redis"

#include "_log"

void SaveRedis()
{
    if (GetLocalString(GetModule(), "SAVE_REDIS") == "FALSE")
    {
        NWNX_Redis_BGSAVE();
        int nTime = NWNX_Time_GetTimeStamp();
        string sTime = IntToString(nTime);
        string sMessage = "Redis is saving : "+ sTime;
        Log(sMessage,"1");
    }
}

void MasterSave(){
    object oPC = OBJECT_SELF;
    SetHeartbeatLocation(oPC); 

    SaveRedis();
}