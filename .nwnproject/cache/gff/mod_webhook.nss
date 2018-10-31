#include "nwnx_webhook"
#include "nwnx_time"

object oMod = GetModule();
string sWebhookUrlPublic  = GetLocalString(oMod, "WEBHOOK_PUBLIC");
string sWebhookUrlPrivate = GetLocalString(oMod, "WEBHOOK_PRIVATE");
string sWebhookUrlDebug   = GetLocalString(oMod, "WEBHOOK_DEBUG");

int iWebhookVarExists();
int iWebhookVarExists()
{
    if ((sWebhookUrlPublic == "") && (sWebhookUrlPrivate == "") && (sWebhookUrlPublic == ""))
    {
        string sMessage = "Missing webhook vars on module, you need these to use webhooks.";
        WriteTimestampedLogEntry(sMessage);
        return 1;
    }
    else {
        return 0;
    }
}

void SendbWebhook(string sPermission, string sMessage, string sSendername)
{
    if (sPermission == "public")
    {
        NWNX_WebHook_SendWebHookHTTPS("discordapp.com/api/webhooks/" + sWebhookUrlPublic + "/slack", sMessage, sSendername);
        return;
    }

    if (sPermission == "private")
    {
        NWNX_WebHook_SendWebHookHTTPS("discordapp.com/api/webhooks/" + sWebhookUrlPrivate + "/slack", sMessage, sSendername);
        return;
    }

    if (sPermission == "debug")
    {
        NWNX_WebHook_SendWebHookHTTPS("discordapp.com/api/webhooks/" + sWebhookUrlDebug + "/slack", sMessage, sSendername);
        return;
    }

    else 
    {
        sMessage = "This isn't a valid value for webhook broadcast level, please try again";
        WriteTimestampedLogEntry(sMessage);
        return;
    }
}

void LoginWebhook(object oPC)
{
    string CurrentTime = NWNX_Time_GetSystemTime();
    string CurrentDate = NWNX_Time_GetSystemDate();
    string sPCName = GetName(oPC);

    // Webhooks
    if(!GetIsDM(oPC))
    {
        string sMessage = sPCName + " logged in at: " + CurrentTime + " || on: " + CurrentDate;
        SendbWebhook("private",sMessage , "Login");
        return;
    }        
    string sMessage = sPCName + " logged in as a DM at: " + CurrentTime + " || on: " + CurrentDate;
    SendbWebhook("public", sMessage , "Login");
}

void LogoutWebhook(object oPC)
{
    string CurrentTime = NWNX_Time_GetSystemTime();
    string CurrentDate = NWNX_Time_GetSystemDate();
    string sPCName = GetName(oPC);

    // Webhooks
    if(!GetIsDM(oPC))
    {
        string sMessage = sPCName + " logged in at: " + CurrentTime + " || on: " + CurrentDate;
        SendbWebhook("private",sMessage , "Logout");
        return;
    }        
    string sMessage = sPCName + " logged in as a DM at: " + CurrentTime + " || on: " + CurrentDate;
    SendbWebhook("public", sMessage , "Logout");
}

void DEBUG_STRING(string sMessage)
{
    string sMessageDate = NWNX_Time_GetSystemDate();
    string sMessageTime = NWNX_Time_GetSystemTime();
    string sMessageFinal = sMessageDate + " " + sMessageTime + " " + sMessage;
    SendbWebhook("debug", sMessageFinal , "DEBUG");
}

void DEBUG_OBJECT(object oObject, string sString)
{
    string sMessageDate = NWNX_Time_GetSystemDate();
    string sMessageTime = NWNX_Time_GetSystemTime();
    string sObject = GetName(oObject,0);  
    string sMessageFinal = sMessageDate + " " + sMessageTime + " : " + sObject + " : " + sString;
    SendbWebhook("debug", sMessageFinal , "DEBUG");
}