#include "mod_player_event"
#include "mod_webhook"

void main()
{
    object oPC = GetEnteringObject();

    // Autoboot banned cd keys
    AutoBoot(oPC);

    // Check if oPC name is prohibited
    NameChecker(oPC);

    // Strip all items from DM.
    StripDM(oPC);

    // Give DM items
    //GiveDMItems(oPC);

    // Apply starting stats
    HeadStart(oPC);

    // Login Webhooks
    LoginWebhook(oPC);

    // break for DM
    if (GetIsDM(oPC))
    {
        return;
    }

    // Load saved information for player.
    //LoadPlayerInfo(oPC);
}
