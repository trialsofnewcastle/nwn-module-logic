string GetPlayerID(object oPC)
{
    string sID;
    sID = GetPCPublicCDKey(oPC, FALSE);
    sID += "_" + GetName(oPC);
    return GetSubString(sID, 0, 20);
}
