#include "nwnx_redis"
#include "mod_player_event"

string sID = GetPlayerID(oPC);

int CheckQuestGiven(object oPC, string sQuestName);
int CheckQuestGiven(object oPC, string sQuestName){
    int nQuestGiven = NWNX_Redis_EXISTS("nwserver:players:"+sID+":"+sQuestName);
    return nQuestGiven;
}

int CheckQuestStatus(object oPC, string sQuestName);
int CheckQuestStatus(object oPC, string sQuestName){
    string sQuestStatus = NWNX_Redis_GET("nwserver:players:"+sID+":"+sQuest);
    int nQuestStatus = StringToInt(sQuestStatus);
    return nQuestStatus;
}

void DeletePersistentQuestString(string sPC,string sQuestName)
{
    string sID   = GetPlayerID(oPC);
    NWNX_Redis_DEL("nwserver:players:"+sID+":"+sQuest);
}

void SetPersistentQuestString(string sPC,string sQuestName, string sValue)
{
    string sID   = GetPlayerID(oPC);
    NWNX_Redis_SET("nwserver:players:"+sID+":"+sQuest, sValue);
}




