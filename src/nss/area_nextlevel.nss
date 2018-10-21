//#include "_debug"
void CreateNextArea(object oPC,string sResRef)
{
    object oOldArea = GetArea(oPC);
    object oArea; 
    string oOldAreaName = GetName(oOldArea);

    string sArea1; 

    int nCurrentLevel = GetLocalInt(oPC,"CURRENTLEVEL");
    int nNextLevel = nCurrentLevel+1;
    string sNextLevel = IntToString(nNextLevel);
    object oNewArea = CreateArea(sArea1, sResRef,"["+sNextLevel+"]");

    object oObject = GetFirstObjectInArea(oNewArea);
    while(GetIsObjectValid(oObject))
    {
        if(GetName(oObject) == "_ENTER")
        {
            SetLocalInt(oPC,"CURRENTLEVEL",nNextLevel);
            SetLocalInt(oPC,"RESTEDTHISLEVEL",0);

            // Teleport player to correct waypoint
            JumpToObject(oObject);

            // Destroy area oPC is currently in after 10 seconds
            // REMOVE ME            DEBUG_OBJECT(oPC,"Destroying: " + oOldAreaName);
            DestroyArea(oOldArea);
            return;
        }
        oObject = GetNextObjectInArea(oArea);
    }
}

void main()
{
    object oPC = OBJECT_SELF;
    object oOldArea = GetArea(oPC);
    string oOldAreaName = GetName(oOldArea);

    // Random for boss, 4 cause 0
    int nBossRandom = Random(4);
    int nRandom = Random(100) + 1;
    // Get vars from player
    int nCurrentLevel = GetLocalInt(oPC,"CURRENTLEVEL");
    int nMaxLevel = GetLocalInt(oPC,"MAXLEVEL");
    string sCurrentLevel = IntToString(nCurrentLevel);
    string sMaxLevel = IntToString(nMaxLevel);

    string sArea1  = "area_res_1",
           sArea2  = "area_res_2",
           sArea3  = "area_res_3",
           sArea4  = "area_res_4",
           sArea5  = "area_res_5",
           sArea6  = "area_res_6",
           sArea7  = "area_res_7",
           sArea8  = "area_res_8",
           sArea9  = "area_res_9",
           sArea10 = "area_res_10",
           sArea11 = "area_res_11",
           sArea12 = "area_res_12",
           sArea13 = "area_res_13",
           sArea14 = "area_res_14",
           sArea15 = "area_res_15",
           sArea16 = "area_res_16",
           sArea17 = "area_res_17",
           sArea18 = "area_res_18",
           sArea19 = "area_res_19",
           sArea20 = "area_res_20",
           sArea21 = "area_boss_1",
           sArea22 = "area_boss_2",
           sArea23 = "area_boss_3",
           sArea24 = "area_boss_4",
           sArea25 = "area_boss_5",
           sArea26 = "area_rest_1",
           sArea99 = "area_end_1";
    // Main shit goes down here

    // Special Room Filter here

    // The Last floor
    if(nCurrentLevel == 100)
    {
        CreateNextArea(oPC,sArea99);
        return;
    }

    // Semi Boss Floors
    if((nCurrentLevel == 4)
    || (nCurrentLevel == 14)
    || (nCurrentLevel == 24)
    || (nCurrentLevel == 34)
    || (nCurrentLevel == 44)
    || (nCurrentLevel == 54)
    || (nCurrentLevel == 64)
    || (nCurrentLevel == 74)
    || (nCurrentLevel == 84)
    || (nCurrentLevel == 94))
    {
        if(nRandom == 0)
        {
            CreateNextArea(oPC,sArea21);
            return;
        }
        if(nRandom == 1)
        {
            CreateNextArea(oPC,sArea22);
            return;
        }
        if(nRandom == 2)
        {
            CreateNextArea(oPC,sArea23);
            return;
        }
        if(nRandom == 3)
        {
            CreateNextArea(oPC,sArea24);
            return;
        }
        if(nRandom == 4)
        {
            CreateNextArea(oPC,sArea25);
            return;
        }
    }

    // Boss Floors
    if((nCurrentLevel == 9)
    || (nCurrentLevel == 19)
    || (nCurrentLevel == 29)
    || (nCurrentLevel == 39)
    || (nCurrentLevel == 49)
    || (nCurrentLevel == 59)
    || (nCurrentLevel == 69)
    || (nCurrentLevel == 79)
    || (nCurrentLevel == 89)
    || (nCurrentLevel == 99))
    {
        if(nRandom == 0)
        {
            CreateNextArea(oPC,sArea21);
            return;
        }
        if(nRandom == 1)
        {
            CreateNextArea(oPC,sArea22);
            return;
        }
        if(nRandom == 2)
        {
            CreateNextArea(oPC,sArea23);
            return;
        }
        if(nRandom == 3)
        {
            CreateNextArea(oPC,sArea24);
            return;
        }
        if(nRandom == 4)
        {
            CreateNextArea(oPC,sArea25);
            return;
        }
    }

    // Chest/Rest room
    if((nCurrentLevel == 10)
    || (nCurrentLevel == 20)
    || (nCurrentLevel == 30)
    || (nCurrentLevel == 40)
    || (nCurrentLevel == 50)
    || (nCurrentLevel == 60)
    || (nCurrentLevel == 70)
    || (nCurrentLevel == 80)
    || (nCurrentLevel == 90))
    {
        if(nRandom == 0)
        {
            CreateNextArea(oPC,sArea26);
            return;
        }
        if(nRandom == 1)
        {
            CreateNextArea(oPC,sArea26);
            return;
        }
        if(nRandom == 2)
        {
            CreateNextArea(oPC,sArea26);
            return;
        }
        if(nRandom == 3)
        {
            CreateNextArea(oPC,sArea26);
            return;
        }
        if(nRandom == 4)
        {
            CreateNextArea(oPC,sArea26);
            return;
        }
    }
    else
    {
        int iRandomBlueprint = Random(19);
        CreateNextArea(oPC, "area_res_" + IntToString(iRandomBlueprint));
        return;
    }

}
