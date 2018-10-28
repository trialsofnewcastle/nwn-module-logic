#include "mod_misc_color"
#include "nwnx_redis_ps"
#include "nwnx_redis"
#include "mod_webhook"
#include "nwnx_admin"
#include "nwnx_time"
#include "x0_i0_position"

int iUptime24H();
int iUptime24H()
{
    int iCurrentTime = NWNX_Time_GetTimeStamp();
    int iBootTime = GetLocalInt(oMod, "RAW_BOOT_TIME");
    int iUpTime = iCurrentTime - iBootTime;
    if (iUpTime > 86400 )
    {
        return 1;
    }
    return 0;
}

int GetIsAPCInArea(object oArea);
int GetIsAPCInArea(object oArea)
{
    object oPC = GetFirstPC();
    while (GetIsObjectValid(oPC))
    {
        oPC = GetNextPC();
        return TRUE;
    }
    return FALSE;
}
