#include "nwnx_time"
#include "nwnx_redis"

void SaveRedis()
{
    if (GetLocalString(GetModule(), "SAVE_REDIS") == "FALSE")
    {
        // SetLocalString(GetModule(), "SAVE_REDIS", "TRUE");
        NWNX_Redis_BGSAVE();
        WriteTimestampedLogEntry("Redis is saving");
        // SetLocalString(GetModule(), "SAVE_REDIS", "FALSE");
    }
}