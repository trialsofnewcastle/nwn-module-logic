#include "nwnx"

// Returns the current date in the format (mm/dd/yyyy)
string NWNX_Time_GetSystemDate();

// Returns current time in the format (24:mm:ss)
string NWNX_Time_GetSystemTime();

// Returns the number of seconds since midnight on January 1, 1970
int NWNX_Time_GetTimeStamp();

// Returns the number of seconds since midnight on January 1, 1970
struct NWNX_Time_HighResTimestamp
{
    int seconds, microseconds;
};
struct NWNX_Time_HighResTimestamp NWNX_Time_GetHighResTimeStamp();

float GetHighResTime();
float GetHighResTime()
{
    struct NWNX_Time_HighResTimestamp hrts = NWNX_Time_GetHighResTimeStamp();
    hrts.seconds -= GetLocalInt(GetModule(), "MODULE_START_SECOND"); // Stored OnModuleLoad

    float res = IntToFloat(hrts.seconds);
    res += IntToFloat(hrts.microseconds) / 1000000.0;
    return res;
}

const string NWNX_Time = "NWNX_Time";

string NWNX_Time_GetSystemDate()
{
    string sFunc = "GetSystemDate";
    NWNX_CallFunction(NWNX_Time, sFunc);
    return NWNX_GetReturnValueString(NWNX_Time, sFunc);
}

string NWNX_Time_GetSystemTime()
{
    string sFunc = "GetSystemTime";
    NWNX_CallFunction(NWNX_Time, sFunc);
    return NWNX_GetReturnValueString(NWNX_Time, sFunc);
}

int NWNX_Time_GetTimeStamp()
{
    string sFunc = "GetTimeStamp";

    NWNX_CallFunction(NWNX_Time, sFunc);
    return NWNX_GetReturnValueInt(NWNX_Time, sFunc);
}

struct NWNX_Time_HighResTimestamp NWNX_Time_GetHighResTimeStamp()
{
    struct NWNX_Time_HighResTimestamp t;
    string sFunc = "GetHighResTimeStamp";

    NWNX_CallFunction(NWNX_Time, sFunc);
    t.microseconds = NWNX_GetReturnValueInt(NWNX_Time, sFunc);
    t.seconds = NWNX_GetReturnValueInt(NWNX_Time, sFunc);
    return t;
}