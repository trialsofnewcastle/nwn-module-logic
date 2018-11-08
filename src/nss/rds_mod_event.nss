#include "nwnx_redis"

#include "log"

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