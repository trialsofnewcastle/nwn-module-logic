#include "mod_misc_color"
#include "nwnx_redis_ps"
#include "nwnx_redis"
#include "mod_webhook"
#include "nwnx_admin"
#include "nwnx_time"
#include "x0_i0_position"


void StripEquipped(object oPC, object oEquip)
{
 if(GetIsObjectValid(oEquip))
    {
    SetDroppableFlag(oEquip, TRUE);
    ActionUnequipItem(oEquip);
    SetPlotFlag(oEquip, FALSE);
    SetItemCursedFlag(oEquip, FALSE);
    DestroyObject(oEquip);
    }

    SendMessageToPC(oPC, Color_Text("red", "Contraband Removed."));

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

void NameChecker(object oPC)
{
    string sName = GetStringUpperCase(GetName(oPC));

    if (FindSubString(sName, "SERVER")                    >= 0  ||
        FindSubString(sName, "PISS")                      >= 0  ||
        FindSubString(sName, "CUNT")                      >= 0  ||
        FindSubString(sName, "COCKSUCKER")                >= 0  ||
        FindSubString(sName, "MOTHERFUCKER")              >= 0  ||
        FindSubString(sName, "BITCH")                     >= 0  ||
        FindSubString(sName, "FUCK")                      >= 0  ||
        FindSubString(sName, "SHIT")                      >= 0  ||
        FindSubString(sName, "ASSHOLE")                   >= 0  ||
        FindSubString(sName, "CUCK")                      >= 0  ||
        FindSubString(sName, "TITS")                      >= 0  ||
        FindSubString(sName, "TITTIES")                   >= 0  ||
        FindSubString(sName, "BALLS")                     >= 0  ||
        FindSubString(sName, "PUSSY")                     >= 0  ||
        FindSubString(sName, "CRUSTY")                    >= 0  ||
        FindSubString(sName, "SMEGMA")                    >= 0  ||
        FindSubString(sName, "HITLERDIDNOTHINGWRONG")     >= 0  ||
        FindSubString(sName, "MOIST")                     >= 0  ||
        FindSubString(sName, "FAGGOT")                    >= 0)
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
// -- Store heartbeat location data
void StoreHeartbeatLocation(object oPC){
  object oArea = GetArea(oPC);
  string sAreaTag = GetTag(oArea);
  string sPcName = GetPCPlayerName(oPC);

  // -- Locate where in the area we are
  vector vPosition = GetPosition(oPC);
 
  // -- Identify the direction we are facing
  float fOrientation = GetFacing(oPC);

  // -- Convert stuff to strings
  string sVector = VectorToString(vPosition);
  string sPcFacing = FloatToString(fOrientation);

  // -- Set Redis
  NWNX_Redis_GETSET("nwserver:players:"+sPcName+":save:heartbeat:areatag",sAreaTag);
  NWNX_Redis_GETSET("nwserver:players:"+sPcName+":save:heartbeat:vector",sVector);
  NWNX_Redis_GETSET("nwserver:players:"+sPcName+":save:heartbeat:facing",sPcFacing);
}    

// -- Store savepoint location data
void SetSavepointLocation(object oPC){
  object oArea = GetArea(oPC);
  string sAreaTag = GetTag(oArea);
  string sPcName = GetPCPlayerName(oPC);

  // -- Locate where in the area we are
  vector vPosition = GetPosition(oPC);
 
  // -- Identify the direction we are facing
  float fOrientation = GetFacing(oPC);

  // -- Convert stuff to strings
  string sVector = VectorToString(vPosition);
  string sPcFacing = FloatToString(fOrientation);

  // -- Set Redis
  NWNX_Redis_GETSET("nwserver:players:"+sPcName+":save:savepoint:areatag",sAreaTag);
  NWNX_Redis_GETSET("nwserver:players:"+sPcName+":save:savepoint:vector",sVector);
  NWNX_Redis_GETSET("nwserver:players:"+sPcName+":save:savepoint:facing",sPcFacing);
}

// -- Store reboot location data
void SetRebootLocation(object oPC){
  object oArea = GetArea(oPC);
  string sAreaTag = GetTag(oArea);
  string sPcName = GetPCPlayerName(oPC);

  // -- Locate where in the area we are
  vector vPosition = GetPosition(oPC);
 
  // -- Identify the direction we are facing
  float fOrientation = GetFacing(oPC);

  // -- Convert stuff to strings
  string sVector = VectorToString(vPosition);
  string sPcFacing = FloatToString(fOrientation);

  // -- Set Redis
  NWNX_Redis_GETSET("nwserver:players:"+sPcName+":save:reboot:facing",sAreaTag);
  NWNX_Redis_GETSET("nwserver:players:"+sPcName+":save:reboot:vector",sVector);
  NWNX_Redis_GETSET("nwserver:players:"+sPcName+":save:reboot:facing",sPcFacing);
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

void SavePC(object oPC){
  ExportSingleCharacter(oPC);
}

void EventSavePC(object oPC){
  SetSavepointLocation(oPC);
  ExportSingleCharacter(oPC);
}


void SaveAllPC()
{
  object oPC = GetFirstPC();
  while(GetIsObjectValid(oPC))
  {
    SavePC(oPC);
    oPC = GetNextPC();
   }
}

void DeleteCharacter(object oPC)
{
  string sPCName = GetName(oPC);
  SendbWebhook("debug","Deleted Character: "+sPCName, "debug");
  NWNX_Administration_DeletePlayerCharacter(oPC);
}

void stripEquipped(object oPC, object oEquip)
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

void AutoBoot(object oPC)
{    
    if(GetLocalInt(oPC, "AUTOBOOT") == 1)  //If a player gets set autoboot, they can't stay connected.
    {                                      //This is to hold off whankers until I can add them to the banned list.
      DelayCommand(3.0, BootPC(oPC));
    }
}