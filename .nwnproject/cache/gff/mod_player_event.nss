#include "mod_misc_color"
#include "mod_webhook"
#include "nwnx_admin"
#include "rds_mod_event"
#include "x0_i0_position"

void SaveAllPC()
{
  object oPC = GetFirstPC();
  while(GetIsObjectValid(oPC))
  {
      ExportSingleCharacter(oPC);
      oPC = GetNextPC();
  }
  SaveRedis();
}

string sPCVector(object oPC){
  vector vPosition    = GetPosition(oPC);
  string sVector      = VectorToString(vPosition);
  return sVector;
}

string sPCFacing(object oPC){
  float fOrientation  = GetFacing(oPC);
  string sPcFacing    = FloatToString(fOrientation);
  return sPcFacing;
}

string sPCAreaTag(object oPC){
  object oArea        = GetArea(oPC);
  string sAreaTag     = GetTag(oArea);
  return sAreaTag;
}

int GetIsAPCInArea(object oArea, int bNPCPartyMembers = TRUE);
int GetIsAPCInArea(object oArea, int bNPCPartyMembers = TRUE)
{
    object oPC = GetFirstPC();
    while (GetIsObjectValid(oPC))
    {
        if(bNPCPartyMembers)
        {
            object oFaction = GetFirstFactionMember(oPC, FALSE);
            while(GetIsObjectValid(oFaction))
            {
                if (GetArea(oFaction) == oArea)
                    return TRUE;
                oFaction = GetNextFactionMember(oPC, FALSE);
            }
        }
        oPC = GetNextPC();
    }
    return FALSE;
}

void HeadStart(object oPC)
{
    int oPCHP = GetXP(oPC);

    if (GetIsDM(oPC))
    {
        return;
    }

    if (oPCHP <= 1000)
    {
        SetXP(oPC, 10000);
        return;
    }
}

void AutoBoot(object oPC)
{
    if(GetLocalInt(oPC, "AUTOBOOT") == 1)  //If a player gets set autoboot, they can't stay connected.
    {                                      //This is to hold off whankers until I can add them to the banned list.
      DelayCommand(3.0, BootPC(oPC));
    }
}

void DeleteCharacter(object oPC)
{
  string sPCName = GetName(oPC);
  SendbWebhook("debug","Deleted Character: "+sPCName, "debug");
  NWNX_Administration_DeletePlayerCharacter(oPC);
}

void StripEquipped(object oPC, object oEquip)
{
 if(GetIsObjectValid(oEquip))
    {
    string sPCName = GetName(oPC);
    string sItemName = GetName(oEquip);
    SetDroppableFlag(oEquip, TRUE);
    ActionUnequipItem(oEquip);
    SetPlotFlag(oEquip, FALSE);
    SetItemCursedFlag(oEquip, FALSE);
    DestroyObject(oEquip);
    SendMessageToPC(oPC, sItemName +" - Contraband Removed.");

    SendbWebhook("debug",sItemName,"Contraband Removed");
    }

}

void Strip(object oPC)
{
   if (GetLocalInt(GetModule(), "DM_INV_STRIP") == TRUE)
       {
        StripEquipped(oPC, GetItemInSlot(INVENTORY_SLOT_ARMS, oPC));
        StripEquipped(oPC, GetItemInSlot(INVENTORY_SLOT_ARROWS, oPC));
        StripEquipped(oPC, GetItemInSlot(INVENTORY_SLOT_BELT, oPC));
        StripEquipped(oPC, GetItemInSlot(INVENTORY_SLOT_BOLTS, oPC));
        StripEquipped(oPC, GetItemInSlot(INVENTORY_SLOT_BOOTS, oPC));
        StripEquipped(oPC, GetItemInSlot(INVENTORY_SLOT_BULLETS, oPC));
        StripEquipped(oPC, GetItemInSlot(INVENTORY_SLOT_CHEST, oPC));
        StripEquipped(oPC, GetItemInSlot(INVENTORY_SLOT_CLOAK, oPC));
        StripEquipped(oPC, GetItemInSlot(INVENTORY_SLOT_HEAD, oPC));
        StripEquipped(oPC, GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC));
        StripEquipped(oPC, GetItemInSlot(INVENTORY_SLOT_LEFTRING, oPC));
        StripEquipped(oPC, GetItemInSlot(INVENTORY_SLOT_NECK, oPC));
        StripEquipped(oPC, GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC));
        StripEquipped(oPC, GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oPC));
       }
}

void EmptyInventory(object oPC)
{
    int iGold = GetGold(oPC);
    object oItem = GetFirstItemInInventory(oPC);

    while (GetIsObjectValid(oItem))
        {
        SetDroppableFlag(oItem, TRUE);
        SetPlotFlag(oItem, FALSE);
        SetItemCursedFlag(oItem, FALSE);
        DestroyObject(oItem);
        oItem = GetNextItemInInventory(oPC);
        }
    AssignCommand(oPC, TakeGoldFromCreature(iGold, oPC, TRUE));
}

void StripDM(object oPC)
{
    // DM Inventory manage
    if (GetIsDM(oPC))
    {
        Strip(oPC);
        EmptyInventory(oPC);
        // GiveSpecialItems(oPC);
        return;
    }
}

void NameChecker(object oPC)
{
    string sName = GetStringUpperCase(GetName(oPC));

    if (FindSubString(sName, "SERVER")                    >= 0  ||
        FindSubString(sName, "TITTIES")                   >= 0  ||
        FindSubString(sName, "SMEGMA")                    >= 0  ||
        FindSubString(sName, "HITLERDIDNOTHINGWRONG")     >= 0)
    {
        SpeakString("Entering Player: " + sName+
       "NAME IS PROHIBITED.", TALKVOLUME_SHOUT);

        WriteTimestampedLogEntry("Entering Player: " + sName+
       "NAME IS PROHIBITED.");

        ClearAllActions(FALSE);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), oPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneImmobilize(), oPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectBlindness(), oPC);

        PopUpDeathGUIPanel(oPC, FALSE, FALSE, 0, ""+
        "Error!!!!  NAME PROHIBITED!!!");

        DelayCommand(6.0, BootPC(oPC, "Error!!!!  NAME PROHIBITED!"));

    }
}


