void SetAreaSpellVar();
void SetAreaSpellVar()
{
    object oArea = GetFirstArea();
    while(GetIsObjectValid(oArea))
    {
        SetLocalInt(oArea, "X2_L_WILD_MAGIC", 1);
        oArea = GetNextArea();
    }
}
