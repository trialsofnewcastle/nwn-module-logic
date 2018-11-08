#include "mod_player_event"

void main()
{

    switch (GetUserDefinedEventNumber()) {

    case 001:
        SpeakString("Check out the Discord: https://discord.gg/utetGn", TALKVOLUME_SHOUT);
        DelayCommand(1800.0, SignalEvent(OBJECT_SELF, EventUserDefined(001)));
        break;

    case 002:
        SaveMaster();
        DelayCommand(600.0, SignalEvent(OBJECT_SELF, EventUserDefined(002)));
    }
}