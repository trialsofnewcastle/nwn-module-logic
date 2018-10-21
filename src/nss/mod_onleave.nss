#include "mod_player_event"
#include "nwnx_time"
#include "mod_webhook"

void main()
{
    object oPC = GetExitingObject();
    object oHide = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC);
    string sName;
    int nHP = GetCurrentHitPoints(oPC);
    int nPCT = (nHP * 100) / GetMaxHitPoints(oPC);

    // Logout webhook
    LogoutWebhook(oPC);

    // If we are a DM we break the script
    if (GetIsDM(oPC))return;

    // Less than 10% Hitpoints, Consider a Death Log
    if (nPCT<10 && GetIsInCombat(oPC))
    {
        object oAttacker = GetLastHostileActor(oPC);

        effect eDam = EffectDamage(nHP+20, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_TWENTY);

        string sMsg = GetName(oAttacker, TRUE) + "autokilled"+GetName(oPC)+
        "for possible deathlog while in COMBAT"+
        "with less than 10% HP!";

        SpeakString(sMsg, TALKVOLUME_SHOUT);
        AssignCommand(oAttacker, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oPC));
    }

    if(GetIsObjectValid(oHide))
    {
       sName = GetLocalString(oHide, "PW-ckey");
    }


    else
    {
       SendMessageToAllDMs("Player: " + GetName(oPC) + " disconnected without a hide.");
       return;
    }


    if(sName == "")
    {
      SendMessageToAllDMs("NULL Prop for Player Hide: " + GetName(oPC));
      return;
    }


    ExportSingleCharacter(oPC);
}
