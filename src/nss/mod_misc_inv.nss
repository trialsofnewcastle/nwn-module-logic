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
void StripDM(object oPC)
{
    // If DM strip inventory
    if (GetIsDM(oPC))
    {
        Strip(oPC);
        EmptyInventory(oPC);
        return;
    }
}


void GiveDMItems(object oPC)
{    
    // give DM items
    if (GetIsDM(oPC))
    {
        Strip(oPC);
        EmptyInventory(oPC);
        return;
    }
}