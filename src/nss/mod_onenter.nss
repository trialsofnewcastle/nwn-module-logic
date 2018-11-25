#include "mod_player_event"
#include "rds_player_event"
#include "mod_webhook"

void main()
{
    object oPC = GetEnteringObject();

    // -- autoboot banned cd keys
    AutoBoot(oPC);

    // -- strip all items from DM.
    StripDM(oPC);

    // -- give DM items
    GiveDMItems(oPC);

    // -- store player information on join
    SetGenericInformation(oPC);

    // -- apply headstart
    HeadStart(oPC);

    // -- login Webhooks
    LoginWebhook(oPC);

    // -- break for DM
    if (GetIsDM(oPC))
    {
        return;
    }
}
