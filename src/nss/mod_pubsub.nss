#include "nwnx_redis_ps"
#include "nwnx_redis"
#include "nwnx_webhook"
#include "nwnx_admin"
#include "nwnx_time"
#include "x0_i0_position"

#include "mod_player_event"

// -- Webhook function
void WebHookGo(string sReason,string sMessage){
  object oMod = GetModule();

  // ---- Webhook Data
  // -- Pull the webhook url data in module vars
  string sPublicWebhookUrl = GetLocalString(oMod,"PUBLIC_WEBHOOK");
  string sPrivateWebhookUrl = GetLocalString(oMod,"PRIVATE_WEBHOOK");

  // -- Timestamp
  string sCurrentTime = NWNX_Time_GetSystemTime();
  string sCurrentDate = NWNX_Time_GetSystemDate();

  // ---- Update Messages
  // -- Module update alert
  if(sReason == "module" && sMessage == "update"){
    string sWebhookMessage = "Module update found:" + sMessage + " || on: " + sCurrentDate;
    SendbWebhook("public", sWebhookMessage , "Reboot");
  }  

  // -- Module Update proceed
  if(sReason == "module"){
    string sWebhookMessage = "Server rebooting for module update:" + sMessage + " || on: " + sCurrentDate;
    SendbWebhook("public", sWebhookMessage , "Reboot");
  }

  // -- Nwnxee Update proceed
  if(sReason == "nwnxee"){
    string sWebhookMessage = "Server rebooting for nwnxee update:" + sMessage + " || on: " + sCurrentDate;
    SendbWebhook("public", sWebhookMessage , "Reboot");
  }

  // -- not in the right place
  else{
    string sWebhookMessage = "Unknown pubsub || on: " + sCurrentDate;
    SendbWebhook("public", sWebhookMessage , "Reboot");
  }
}

// -- The fun stuff
void ContinuousIntegration(string sReason, string sMessage)
{    
  object oMod = GetModule();

  // ---- Module alerts
  // -- Module update alert
  if(sReason == "module" && sMessage == "update"){
    string sBuiltstring = "Module update detected: " + sMessage;
    ActionSpeakString(sBuiltstring,TALKVOLUME_SHOUT);
    WebHookGo(sReason,sMessage);
    return;
  }  
  
  // ---- Shutdown process
  // -- Nwnxee update save process
  if(sReason == "nwnxee"){
    object oPC = GetFirstPC();
    while (GetIsObjectValid(oPC) == TRUE)
    {
      SetRebootLocation(oPC);
      ExportSingleCharacter(oPC);
      object oPC = GetNextPC();
    }
  }

  // -- Module update save process
  if(sReason == "module"){
    object oPC = GetFirstPC();
    while (GetIsObjectValid(oPC) == TRUE)
    {
      SetRebootLocation(oPC);
      ExportSingleCharacter(oPC);
      object oPC = GetNextPC();
    }

  }
  
  // -- Password lock the server
  NWNX_Administration_SetPlayerPassword("!@#$%^&*()");
  
  // -- Save the database
  NWNX_Redis_SAVE();

  // -- Webhooks
  WebHookGo(sReason,sMessage);

  // -- If base nwnxee docker image updates we have to restart
  if(sReason == "nwnxee"){
    object oPC = GetFirstPC();
    while (GetIsObjectValid(oPC) == TRUE)
    {
      ActivatePortal(oPC,sMessage,"","",TRUE);
      object oPC = GetNextPC();
    }

  }

  // -- If module is updated no need to restart
  if(sReason == "module"){
    object oPC = GetFirstPC();
    while (GetIsObjectValid(oPC) == TRUE)
    {
      StartNewModule(GetName(oMod));
      object oPC = GetNextPC();
    }

  }
}

void main()
{
  struct NWNX_Redis_PubSubMessageData data = NWNX_Redis_GetPubSubMessageData();

  // -- Triggers when pubsub message comes in on the "updating" channel
  if((data.channel == "module") && (data.message == "alert"))
  {
    WriteTimestampedLogEntry("Pubsub Event: channel=" + data.channel + " message=" + data.message);
    ContinuousIntegration(data.channel,data.message);
  }

  // -- Triggers when pubsub message comes in on the "module" channel
  if(data.channel == "module"&& data.message == "proceed")
  {
    WriteTimestampedLogEntry("Pubsub Event: channel=" + data.channel + " message=" + data.message);
    ContinuousIntegration(data.channel,data.message);
  }

  // -- Triggers when pubsub message comes in on the "nwnxee" channel
  if(data.channel == "nwnxee" && data.message == "proceed")
  {
    WriteTimestampedLogEntry("Pubsub Event: channel=" + data.channel + " message=" + data.message);
    ContinuousIntegration(data.channel,data.message);
  }
}