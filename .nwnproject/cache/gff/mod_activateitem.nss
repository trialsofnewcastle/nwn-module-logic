void main()
{

   object oItem=GetItemActivated();
   object oActivator=GetItemActivator();

   if(GetTag(oItem)=="handheldbank")
   {
      ExecuteScript("rds_itm_hhb_use", oActivator);
      return;
   }

//   // multiple use item template
//   if(GetTag(oItem)=="summonbats")
//   {
//      ExecuteScript("summonbats1", oActivator);
//      return;
//   }
//
//   // one use item template
//   if(GetTag(oItem)=="baricksincantati")
//   {
//      ExecuteScript("unlckorthdoor1", oActivator);
//      DestroyObject(oItem, 3.1);
//      return;
//   }
//
//   // dm item template
//   if(GetTag(oItem)=="dn_w_fogwand")
//   {
//      if(checkdmcdkey(oActivator) == FALSE)
//      {
//        DestroyObject(oItem);
//        SendMessageToPC(oActivator,"You are mortal and this is not yours!");
//        return;
//      }
//
//      ExecuteScript("dn_w_fogwand", oActivator);
//      return;
//   }
}
