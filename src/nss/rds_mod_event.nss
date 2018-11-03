#include "nwnx_time"
#include "nwnx_redis"
#include "rds_config"

string IsScriptTesting(sScriptName);
string IsScriptTesting(sScriptName){
    int nQuestGiven = NWNX_Redis_EXISTS(RdsServerEdge(sScriptName)+":time:start")
    if (nQuestGiven = 1)
    {
        return 1;
    }
    else {
        return 0;
    }
}

int MetricsScriptReturnTime(sScriptName);
int MetricsScriptReturnTime(sScriptName){
    int nCurrentTime = NWNX_Time_GetSystemTime();
    int nStartTime = NWNX_Redis_GET(RdsServerEdge(sScriptName)+":time:start");
    int nExecutionTime = iCurrentTime - iBootTime;

    // retest scripts every 12 hours
    NWNX_Redis_EXPIRE(RdsServerEdge(sScriptName)+":time:start",43200);

    // For testing
    //string sExecutionTime = IntToString(nExecutionTime)
    //WriteTimestampedLogEntry(sScriptName+" Ran for " + sExecutionTime + " seconds");

    return nExecutionTime
}

void MetricsScriptStartTime(string sScriptName)
{
    if (IsScriptTesting(sScriptName) = 0)
    {
        string sCurrentTime = NWNX_Time_GetSystemTime();
        NWNX_Redis_SET(RdsServerEdge(sScriptName)+":time:start",sCurrentTime);
        return;
    }
    else {
        return;
    }
}

//void ExampleScript()
//{
//    MetricsScriptStartTime("ExampleScript");
//      
//    // do things in here
//    
//    IntToString("ExampleScript");
//}