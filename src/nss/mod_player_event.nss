#include "mod_misc_color"
#include "mod_webhook"
#include "nwnx_admin"
#include "x0_i0_position"

// -- get vector of the oPC
string PCVector(object oPC){
  vector vPosition    = GetPosition(oPC);
  string sVector      = VectorToString(vPosition);
  return sVector;
}

// -- get the facing value of the oPC
string PCFacing(object oPC){
  float fOrientation  = GetFacing(oPC);
  string sPcFacing    = FloatToString(fOrientation);
  return sPcFacing;
}

// -- get areatag of the oPC
string PCAreaTag(object oPC){
  object oArea        = GetArea(oPC);
  string sAreaTag     = GetTag(oArea);
  return sAreaTag;
}

// -- get if a player is in an area
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

// -- give an authorized mortal dm items
void GiveDMItems(object oPC)
{

}

// -- apply headstart value
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

// -- Will boot the player if they have the AUTOBOOT int set oPC
void AutoBoot(object oPC)
{
    if(GetLocalInt(oPC, "AUTOBOOT") == 1)  //If a player gets set autoboot, they can't stay connected.
    {                                      //This is to hold off whankers until I can add them to the banned list.
      DelayCommand(3.0, BootPC(oPC));
    }
}

// -- delete character of oPC
void DeleteCharacter(object oPC)
{
  string sPCName = GetName(oPC);
  SendbWebhook("debug","Deleted Character: "+sPCName, "debug");
  NWNX_Administration_DeletePlayerCharacter(oPC);
  BootPC(oPC);
}

// -- Delete item and send message to player
void DeleteItem(object oPC, object oEquip)
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

// -- strip item from equipped slot
void Strip(object oPC)
{
   if (GetLocalInt(GetModule(), "DM_INV_STRIP") == TRUE)
       {
        DeleteItem(oPC, GetItemInSlot(INVENTORY_SLOT_ARMS, oPC));
        DeleteItem(oPC, GetItemInSlot(INVENTORY_SLOT_ARROWS, oPC));
        DeleteItem(oPC, GetItemInSlot(INVENTORY_SLOT_BELT, oPC));
        DeleteItem(oPC, GetItemInSlot(INVENTORY_SLOT_BOLTS, oPC));
        DeleteItem(oPC, GetItemInSlot(INVENTORY_SLOT_BOOTS, oPC));
        DeleteItem(oPC, GetItemInSlot(INVENTORY_SLOT_BULLETS, oPC));
        DeleteItem(oPC, GetItemInSlot(INVENTORY_SLOT_CHEST, oPC));
        DeleteItem(oPC, GetItemInSlot(INVENTORY_SLOT_CLOAK, oPC));
        DeleteItem(oPC, GetItemInSlot(INVENTORY_SLOT_HEAD, oPC));
        DeleteItem(oPC, GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC));
        DeleteItem(oPC, GetItemInSlot(INVENTORY_SLOT_LEFTRING, oPC));
        DeleteItem(oPC, GetItemInSlot(INVENTORY_SLOT_NECK, oPC));
        DeleteItem(oPC, GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC));
        DeleteItem(oPC, GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oPC));
       }
}

// -- empty out the inventory of oPC
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

// -- strip the dm of items
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


