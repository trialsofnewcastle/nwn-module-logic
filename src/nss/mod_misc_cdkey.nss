//Detect our DMs by public Key as well as DM Flag
int booldmkey(object oPC)  //These are real DMs.
{
   string sCDkey = GetPCPublicCDKey(oPC);

   if(GetIsDM(oPC))
   {
      return TRUE;
   }

   if(sCDkey == "x"  //
   || sCDkey == "x"  // 
   || sCDkey == "x"  // 
   || sCDkey == "x"  // 
   || sCDkey == "x"  // 
   || sCDkey == "x"  // 
   || sCDkey == "x"  // 
   || sCDkey == "x") // 
   {
      return TRUE;
   }
   return FALSE;   //Default is no access.
}

int boolmodkey(object oPlayer) //The player is not a DM, but is privalaged to have special items.
{
   string skey = GetPCPublicCDKey(oPlayer);

   if(checkdmcdkey(oPlayer) == TRUE)
   {
     return TRUE;
   }

   if(skey == "xxxxxxxx"  // person1
   || skey == "xxxxxxxx"  // person2
   || skey == "xxxxxxxx") // person3
   {
      return TRUE;
   }

   return FALSE;
}
