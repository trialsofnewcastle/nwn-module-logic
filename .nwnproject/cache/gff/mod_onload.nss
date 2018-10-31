#include "nwnx_time"
#include "mod_webhook"

void main()
{
    object oMod = GetModule();

    // -- Protect against naughty DMs
    SetLocalInt(oMod, "DM_INV_STRIP", TRUE);

    // -- Creature vars
    SetLocalInt(oMod, "X2_SWITCH_ENABLE_UMD_SCROLLS", TRUE);
    SetLocalString(oMod, "X2_S_UD_SPELLSCRIPT", "mod_spellhook");

    // -- webhook vars
    SetLocalString(oMod, "DEBUG_WEBHOOK", "/api/webhooks///slack");      
    SetLocalString(oMod, "PRIVATE_WEBHOOK", "/api/webhooks///slack");
    SetLocalString(oMod, "PUBLIC_WEBHOOK", "/api/webhooks///slack");

    string sPublicWebhookUrl = GetLocalString(oMod,"PUBLIC_WEBHOOK");
    string sPrivateWebhookUrl = GetLocalString(oMod,"PRIVATE_WEBHOOK");

    // -- Webhook shit
    string sCurrentTime = NWNX_Time_GetSystemTime();
    string sCurrentDate = NWNX_Time_GetSystemDate();

    // -- Boot Message
    string sMessage = "Server booted at:" + sCurrentTime + " || on: " + sCurrentDate;
    SendbWebhook("public",sMessage,"Booting");


    // -- Boot Time
    int iRawBootTime = NWNX_Time_GetTimeStamp();
    string sBootTime = NWNX_Time_GetSystemTime();
    string sBootDate = NWNX_Time_GetSystemDate();
    SetLocalInt(oMod, "RAW_BOOT_TIME", iRawBootTime);
    SetLocalString(oMod, "BOOT_TIME", sBootTime);
    SetLocalString(oMod, "BOOT_DATE", sBootDate);

    // -- Start the MOTD delay timer
    DelayCommand(1800.0, SignalEvent(OBJECT_SELF, EventUserDefined(001)));
    // -- Start the export characters timer
    DelayCommand(600.0, SignalEvent(OBJECT_SELF, EventUserDefined(002)));

    // ---- Setting module events
    // -- Module OnHeartbeat Event
    SetEventScript(oMod,3000,"mod_heartbeat");
    // -- Module OnUserDefined Event
    SetEventScript(oMod,3001,"mod_userdefined");
    // -- Module OnModuleLoad Event
    SetEventScript(oMod,3002,"mod_onload");
    // --ON_MODULE_START
    //SetEventScript(oMod,3003,myhopesanddreams);
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
}