#include "nwnx_time"
#include "nwnx_redis"
#include "nwnx_events"
#include "order_time"

#include "rds_config"
#include "mod_webhook"
#include "_save"
#include "_log"

void main(){
    object oMod = GetModule();
    Log("Server is starting","1");

    ///////////////////////
    // -- Module vars -- //
    ///////////////////////
    // -- If set to true, dm's will not be able to bring in external items.
    SetLocalInt(oMod, "DM_INV_STRIP", TRUE);
    // -- UMD var
    SetLocalInt(oMod, "X2_SWITCH_ENABLE_UMD_SCROLLS", TRUE);
    // -- Spellhook var
    SetLocalString(oMod, "X2_S_UD_SPELLSCRIPT", "mod_spellhook");

    ////////////////////////
    // -- Startup info -- //
    ////////////////////////
    // --redis db size
    string sDBSize = IntToString(NWNX_Redis_DBSIZE());
    // -- write to console
    WriteTimestampedLogEntry("Redis keys stored: " + sDBSize);

    // -- Return the correct Time from order
    int nHour =         OrderGetTimeHour();
    int nMinute =       OrderGetTimeMinute();
    int nSecond =       OrderGetTimeSecond();
    int nMillisecond =  OrderGetTimeMillisecond();

    // -- Boot Time
    int iRawBootTime = NWNX_Time_GetTimeStamp();
    string sBootTime = NWNX_Time_GetSystemTime();
    string sBootDate = NWNX_Time_GetSystemDate();

    // -- webhook
    string sWebhookDebug =   "/api/webhooks///slack";   
    string sWebhookPublic =  "/api/webhooks///slack";
    string sWebhookPrivate = "/api/webhooks///slack"; 

    ///////////////////////////////////////////////////////
    // -- Do the things with all the data we gathered -- //
    ///////////////////////////////////////////////////////

    // -- Apply values to redis
    NWNX_Redis_HMSET(RdsEdgeServer("server")+":serverstats", "BootTime", sBootTime);
    NWNX_Redis_HMSET(RdsEdgeServer("server")+":serverstats", "BootDate", sBootDate);
    NWNX_Redis_HMSET(RdsEdgeServer("server")+":serverstats", "WebhookDebug", sWebhookDebug);
    NWNX_Redis_HMSET(RdsEdgeServer("server")+":serverstats", "WebhookPublic", sWebhookPublic);
    NWNX_Redis_HMSET(RdsEdgeServer("server")+":serverstats", "WebhookPrivate", sWebhookPrivate);       

    // -- debug
    string sDebug = NWNX_Redis_HGET(RdsEdgeServer("server")+":serverstats", "WebhookDebug");
    Log(sDebug, "1");
    SaveRedis();

    ////////////////////////////////////////
    // -- Setting module script events -- //
    ////////////////////////////////////////
    // -- Module OnHeartbeat Event
    SetEventScript(oMod,3000,"mod_heartbeat");
    // -- Module OnUserDefined Event
    SetEventScript(oMod,3001,"mod_userdefined");
    // -- Module OnClientEnter Event
    SetEventScript(oMod,3004,"mod_onenter");
    // -- Module OnClientLeave Event
    SetEventScript(oMod,3005,"mod_onleave");
    // -- Module OnActivateItem Event
    SetEventScript(oMod,3006,"mod_activateitem");
    // -- Module OnAcquireItem Event
    SetEventScript(oMod,3007,"mod_acquireitem");
    // -- Module OnUnAcquireItem Event
    SetEventScript(oMod,3008,"mod_unacquireitem");
    // -- Module OnPlayerDeath Event
    SetEventScript(oMod,3009,"mod_playerdeath");
    // -- Module OnPlayerDying Event
    SetEventScript(oMod,3010,"mod_playerdying");
    // -- Module OnPlayerRespawn Event
    SetEventScript(oMod,3011,"mod_respawn");
    // -- Module OnPlayerRest Event
    SetEventScript(oMod,3012,"mod_rest");
    // -- Module OnPlayerLevelUp Event
    SetEventScript(oMod,3013,"mod_levelup");
    // -- Module OnCutsceneAbort Event
    SetEventScript(oMod,3014,"mod_cutsceneabrt");
    // -- Module OnPlayerEquipItem Event
    SetEventScript(oMod,3015,"mod_equipitem");
    // -- Module OnPlayerUnequipItem Event
    SetEventScript(oMod,3016,"mod_unequipitem");
    // -- Module OnPlayerChat Event
    SetEventScript(oMod,3017,"mod_chat");

    // -- Module NWNX Events
    NWNX_Events_SubscribeEvent("NWNX_ON_PARTY_ACCEPT_INVITATION_BEFORE", "e_party_accept_b");
    NWNX_Events_SubscribeEvent("NWNX_ON_PARTY_LEAVING_AFTER", "e_party_leave_a");
    NWNX_Events_SubscribeEvent("NWNX_ON_USE_ITEM_BEFORE", "e_item_use_b");
    
    
    // -- Final Boot Message
    string sBootMessage = "Server booted at:" + sBootTime + " || on: " + sBootDate;
    Log(sBootMessage, "1");

    // -- Start the MOTD delay timer
    DelayCommand(1800.0, SignalEvent(OBJECT_SELF, EventUserDefined(001)));
    // -- Start the export characters timer
    DelayCommand(600.0, SignalEvent(OBJECT_SELF, EventUserDefined(002)));

}