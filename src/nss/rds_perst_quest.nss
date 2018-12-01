#include "nwnx_redis"
#include "mod_player_event"
#include "rds_player_event"

string GetCurrentActiveQuests(object oPC);
string GetCurrentActiveQuests(object oPC){
    string sQuests = NWNX_Redis_HGETALL(RdsPlayerEdge(oPC)+":quests");
    return sQuests;
}

// -- return if sQuestName has been given to oPC
int CheckQuestGiven(object oPC, string sQuestName);
int CheckQuestGiven(object oPC, string sQuestName){
    int nQuestGiven = NWNX_Redis_EXISTS(RdsPlayerEdge(oPC)+":quests",sQuestName);
    return nQuestGiven;
}

// -- return the sQuestName's quest status
int CheckQuestStatus(object oPC, string sQuestName);
int CheckQuestStatus(object oPC, string sQuestName){
    string sQuestStatus = NWNX_Redis_GET(RdsPlayerEdge(oPC)+":quests",sQuestName);
    int nQuestStatus = StringToInt(sQuestStatus);
    return nQuestStatus;
}

// -- delete the quest sQuestName
void DeletePersistentQuestString(string sPC,string sQuestName)
{
    NWNX_Redis_HDEL(RdsPlayerEdge(oPC)+":quests:",sQuestName);
}

// -- set the quest sQuestName
void SetPersistentQuestString(string sPC,string sQuestName, string sValue)
{
    NWNX_Redis_HMSET(RdsPlayerEdge(oPC)+":quests", sQuestName, sValue);
}


//  Trials of Newcastle
//  inc_quests
//  Dorrian and Urothis

/*
Quests and Journals
*/

#include "nwnx_redis"
#include "inc_control"
#include "inc_memory"

void AddQuestEntry(string sQuestName, int nState, object oPC, int bAllPartyMembers=FALSE, int bAllPlayers=FALSE, int bAllowOverrideHigher=FALSE);
void RemoveQuest(string sQuestName, object oPC, int iWholeParty=FALSE, int iAllPlayers=FALSE);
void RebuildJournalEntries(object oPC);
int RetrieveQuestState(object oPC, string sQuestName);
int QuestGold(object oPC);
int CheckQuestChainHeld(object oPC, string sQuestName);
void DeleteQuestState(object oPC, string sQuestName);
void SetQuestState(object oPC, string sQuestName, string sValue);

// -----------------------------------------------------------------------------

int QuestGold(object oPC){
    int iGold;

    if (GetHitDice(oPC) <= 3) {iGold = QUEST_GOLD;}
    else {iGold = (GetHitDice(oPC)/2)*QUEST_GOLD;}

    return iGold;
}

void SetQuestState(object oPC, string sQuestName, string sValue){
    string sID   = GetPlayerID(oPC);
    NWNX_Redis_SET("nwserver:players:"+sID+":"+sQuestName, sValue);
}

int RetrieveQuestState(object oPC, string sQuestName){
    string sID   = GetPlayerID(oPC);

    if (!CheckQuestChainHeld(oPC, sQuestName)) {return 0;}

    else
        {string sState = NWNX_Redis_GET("nwserver:players:"+sID+":"+sQuestName);

        int iState = StringToInt(sState);
        return iState;}
}

void DeleteQuestState(object oPC, string sQuestName){
    if (CheckQuestChainHeld(oPC, sQuestName))
        {string sID   = GetPlayerID(oPC);
        NWNX_Redis_DEL("nwserver:players:"+sID+":"+sQuestName);}
}

int CheckQuestChainHeld(object oPC, string sQuestName){
    string sID   = GetPlayerID(oPC);
    int nQuestStatus = NWNX_Redis_EXISTS("nwserver:players:"+sID+":"+sQuestName);

    if (nQuestStatus >= 1) return TRUE;
    else return FALSE;
}

void StoreQuest(string sQuestName, int iState, object oPC, int iAllowOverrideHigher=FALSE){
  int iCurrentState;
  string sState = IntToString(iState);

  if (CheckQuestChainHeld(oPC, sQuestName)){
      iCurrentState = RetrieveQuestState(oPC, sQuestName);
  } else {
      iCurrentState = 0;
  }


  if (iState > iCurrentState) {SetQuestState(oPC, sQuestName, sState);}

  else if ((iState < iCurrentState) && (iAllowOverrideHigher == TRUE))
    {SetQuestState(oPC, sQuestName, sState);}

  else return;
}

void RemoveQuest(string sQuestName, object oPC, int iWholeParty=TRUE, int iAllPlayers=FALSE)
{
  RemoveJournalQuestEntry(sQuestName, oPC, iWholeParty, iAllPlayers);

  if(iAllPlayers)
    {object oPC = GetFirstPC();

    while(GetIsObjectValid(oPC))
    {if(GetIsPC(oPC))   DeleteQuestState(oPC, sQuestName);
    oPC = GetNextPC();}}

  else if(iWholeParty)
    {object oPartyMember = GetFirstFactionMember(oPC, TRUE);

    while (GetIsObjectValid(oPartyMember))
    {DeleteQuestState(oPartyMember, sQuestName);
    oPartyMember = GetNextFactionMember(oPC, TRUE);}}

  else
    {DeleteQuestState(oPC, sQuestName);}
}


void AddQuestEntry(string sQuestName, int iState, object oPC, int iWholeParty=TRUE, int iAllPlayers=FALSE, int iAllowOverrideHigher=FALSE)
{
  AddJournalQuestEntry(sQuestName, iState, oPC, iWholeParty, iAllPlayers, iAllowOverrideHigher);

  if(iAllPlayers)
    {object oPC = GetFirstPC();

    while(GetIsObjectValid(oPC))
    {if(GetIsPC(oPC)) StoreQuest(sQuestName, iState, oPC, iAllowOverrideHigher);
      oPC = GetNextPC();}}

  else if(iWholeParty)
    {object oPartyMember = GetFirstFactionMember(oPC, TRUE);

    while (GetIsObjectValid(oPartyMember))
    {StoreQuest(sQuestName, iState, oPartyMember, iAllowOverrideHigher);
    oPartyMember = GetNextFactionMember(oPC, TRUE);}}

  else
    {StoreQuest(sQuestName, iState, oPC, iAllowOverrideHigher);}
}
void RebuildJournalEntries(object oPC)
{
    int iLevelBracket;
    int iLvl = GetHitDice(oPC);

    if (iLvl < 10) iLevelBracket = 1;
    else iLevelBracket = 2;

    AddJournalQuestEntry("A_SERVER_PLOT", iLevelBracket, oPC, FALSE, FALSE, FALSE); // The int is an issue
    AddJournalQuestEntry("A_SERVER_RULES", 1, oPC, FALSE, FALSE, FALSE);

    if (iLvl>= 2){
    AddJournalQuestEntry("QUESTS_A_CROWN", RetrieveQuestState(oPC, "QUESTS_A_CROWN"), oPC, FALSE, FALSE, FALSE);}
    if (CheckQuestChainHeld(oPC, "QUESTS_MOIRA")) {AddJournalQuestEntry("QUESTS_MOIRA", RetrieveQuestState(oPC, "QUESTS_MOIRA"), oPC, FALSE, FALSE, FALSE);}
    if (CheckQuestChainHeld(oPC, "QUESTS_HOLANG")) {AddJournalQuestEntry("QUESTS_HOLANG", RetrieveQuestState(oPC, "QUESTS_HOLANG"), oPC, FALSE, FALSE, FALSE);}
    if (CheckQuestChainHeld(oPC, "QUESTS_ADDO")) {AddJournalQuestEntry("QUESTS_ADDO", RetrieveQuestState(oPC, "QUESTS_ADDO"), oPC, FALSE, FALSE, FALSE);}


    if (iLvl > 9){
    if (CheckQuestChainHeld(oPC, "GUILD_COVEN")) {AddJournalQuestEntry("GUILD_COVEN", RetrieveQuestState(oPC, "GUILD_COVEN"), oPC, FALSE, FALSE, FALSE);}
    else if (CheckQuestChainHeld(oPC, "GUILD_CRUSADERS")) {AddJournalQuestEntry("GUILD_CRUSADERS", RetrieveQuestState(oPC, "GUILD_CRUSADERS"), oPC, FALSE, FALSE, FALSE);}
    else if (CheckQuestChainHeld(oPC, "GUILD_WINDS")) {AddJournalQuestEntry("GUILD_WINDS", RetrieveQuestState(oPC, "GUILD_WINDS"), oPC, FALSE, FALSE, FALSE);}}

}