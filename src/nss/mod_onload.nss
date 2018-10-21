#include "nwnx_time"
#include "nwnx_webhook"
#include "mod_misc_crespel"

void main()
{
    object oMod = GetModule();

    // -- Protect against naughty DMs
    SetLocalInt(oMod, "DM_INV_STRIP", TRUE);

    // -- Creature vars
    SetLocalInt(oMod, "X2_SWITCH_ENABLE_UMD_SCROLLS", TRUE);
    SetLocalString(oMod, "X2_S_UD_SPELLSCRIPT", "mod_spellhook");

    // -- webhook vars
    SetLocalString(oMod, "DEBUG_WEBHOOK", "/api/webhooks/475473097919823883/k-BmQ3QVSC9IgOsgeQcUQv_SDyqseAJGXifGNNqIfp_8nE6qeA0VCZA6UZBSsajvk0Hm/slack");      
    SetLocalString(oMod, "PRIVATE_WEBHOOK", "/api/webhooks/475472695622893578/-HoW1MKPT3RNl5QYmwRhxBLujbl0QzrTQ_nbnXlM56zm457s-xc3K-457-sliGdqvpR7/slack");
    SetLocalString(oMod, "PUBLIC_WEBHOOK", "/api/webhooks/475473239888494593/-a6WdyNUD7xkXGg_PIBsIwNM1QxZkMgXXhfGV3CV2ULDbNwtspm9O9AR0Z4ANndnsfzI/slack");

    // -- Set var so npcs use spellhooked scripts
    SetAreaSpellVar();

    string sPublicWebhookUrl = GetLocalString(oMod,"PUBLIC_WEBHOOK");
    string sPrivateWebhookUrl = GetLocalString(oMod,"PRIVATE_WEBHOOK");

    // -- Webhook shit
    string sCurrentTime = NWNX_Time_GetSystemTime();
    string sCurrentDate = NWNX_Time_GetSystemDate();

    // -- Boot Message
    string sMessageLine1 = "Server booted at:" + sCurrentTime + " || on: " + sCurrentDate;
    string sMessageLine2 = " ";
    string sMessageLine3 = " ";
    string sMessageLine4 = " ";
    string sMessageLine5 = " ";

    NWNX_WebHook_SendWebHookHTTPS("discordapp.com",sPublicWebhookUrl, sMessageLine1 , "Booting");
    NWNX_WebHook_SendWebHookHTTPS("discordapp.com",sPublicWebhookUrl, sMessageLine2 , "Booting");
    NWNX_WebHook_SendWebHookHTTPS("discordapp.com",sPublicWebhookUrl, sMessageLine3 , "Booting");
    NWNX_WebHook_SendWebHookHTTPS("discordapp.com",sPublicWebhookUrl, sMessageLine4 , "Booting");
    NWNX_WebHook_SendWebHookHTTPS("discordapp.com",sPublicWebhookUrl, sMessageLine5 , "Booting");


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
}