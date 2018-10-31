const int ST_VAR_STORAGE = 2;
const string ST_VAR_STORAGE_ITEM = "";

int st_GetInt(object oPlayer, string sVariable)
{
  object oHolder;
  int nReturn;
  switch(ST_VAR_STORAGE)
  {
    case 0: oHolder = GetModule(); break;
    case 1: oHolder = GetItemPossessedBy(oPlayer, ST_VAR_STORAGE_ITEM); break;
    case 2: oHolder = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPlayer); break;
    default: break;
  }
  if(GetIsObjectValid(oHolder))
  {
    string sVar = sVariable + GetName(oPlayer) + GetPCPlayerName(oPlayer);
    nReturn = GetLocalInt(oHolder, sVar);
  }
  return nReturn;
}

/******************************************************************************/

void st_SetInt(object oPlayer, string sVariable, int nValue)
{
  object oHolder;
  switch(ST_VAR_STORAGE)
  {
    case 0: oHolder = GetModule(); break;
    case 1: oHolder = GetItemPossessedBy(oPlayer, ST_VAR_STORAGE_ITEM); break;
    case 2: oHolder = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPlayer); break;
    default: break;
  }
  if(GetIsObjectValid(oHolder))
  {
    string sVar = sVariable + GetName(oPlayer) + GetPCPlayerName(oPlayer);
    SetLocalInt(oHolder, sVar, nValue);
  }
}

void st_SpellCast(int nSpellId, object oCaster = OBJECT_SELF)
{
  if(GetIsPC(oCaster) && !GetIsDM(oCaster) && !GetIsDMPossessed(oCaster))
  {
// Check that the spell was not cast from an item (stave, scroll, wand etc)
    if(!GetIsObjectValid(GetSpellCastItem()))
    {
// Increment the variable holding the number of time this spell has been cast
      string sVar = "st_NumSpellCast_"+IntToString(nSpellId)+"_";
      int nCasts = st_GetInt(oCaster,sVar) + 1;
      st_SetInt(oCaster,sVar,nCasts);
    }
  }
}

void main()
{
  object oTarget = GetSpellTargetObject();
  object oCaster = OBJECT_SELF;
  int nID = GetSpellId();
  location lLocal = GetSpellTargetLocation();

  //No AOE stacking
  if (nID == SPELL_ACID_FOG ||
      nID == SPELL_BLADE_BARRIER ||
      nID == SPELL_CLOUD_OF_BEWILDERMENT ||
      nID == SPELL_CLOUDKILL ||
      nID == SPELL_ENTANGLE ||
      nID == SPELL_EVARDS_BLACK_TENTACLES ||
      nID == SPELL_GREASE ||
      nID == SPELL_INCENDIARY_CLOUD ||
      nID == SPELL_STINKING_CLOUD ||
      nID == SPELL_STONEHOLD ||
      nID == SPELL_STORM_OF_VENGEANCE ||
      nID == SPELL_WALL_OF_FIRE ||
      nID == SPELL_WEB)
    {
      //Check aoe
      oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 1.67,lLocal,FALSE,OBJECT_TYPE_AREA_OF_EFFECT);
      while (GetIsObjectValid(oTarget))
      {
        if(GetObjectType(oTarget) == OBJECT_TYPE_AREA_OF_EFFECT)
        {
            if(oCaster  == GetAreaOfEffectCreator(oTarget))
            {
            //Things that happen if the spell triggers the no aoe stacking
            DestroyObject (oTarget);
            FloatingTextStringOnCreature("No AoE Spell stacking allowed.  Minimum 2 meter radius.", oCaster);
            }
        }
        oTarget =GetNextObjectInShape(SHAPE_SPHERE, 1.67,lLocal,FALSE,OBJECT_TYPE_AREA_OF_EFFECT);
    }
    return;
  }
  else
  {
  st_SpellCast(nID);
  }
}

