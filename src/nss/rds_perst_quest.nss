#include "nwnx_redis"
#include "mod_player_event"
#include "rds_player_event"

// -- return if sQuestName has been given to oPC
int CheckQuestGiven(object oPC, string sQuestName);
int CheckQuestGiven(object oPC, string sQuestName){
    int nQuestGiven = NWNX_Redis_EXISTS(RdsPlayerEdge(oPC)+":quests:"+sQuestName);
    return nQuestGiven;
}

// -- return the sQuestName's quest status
int CheckQuestStatus(object oPC, string sQuestName);
int CheckQuestStatus(object oPC, string sQuestName){
    string sQuestStatus = NWNX_Redis_GET(RdsPlayerEdge(oPC)+":quests:"+sQuestName);
    int nQuestStatus = StringToInt(sQuestStatus);
    return nQuestStatus;
}

// -- delete the quest sQuestName
void DeletePersistentQuestString(string sPC,string sQuestName)
{
    NWNX_Redis_DEL(RdsPlayerEdge(oPC)+":quests:"+sQuestName);
}

// -- start the quest sQuestName
void SetPersistentQuestString(string sPC,string sQuestName, string sValue)
{
    NWNX_Redis_SET(RdsPlayerEdge(oPC)+":quests:"+sQuestName, sValue);
}