#include "mod_player_event"

void main()
{
switch (GetUserDefinedEventNumber()) 
    {
    case 001:{
        SpeakString("Shouting", TALKVOLUME_SHOUT);
        SpeakString("Prolly wanna change this", TALKVOLUME_SHOUT);
        DelayCommand(5400.0, SignalEvent(OBJECT_SELF, EventUserDefined(001)));
        break;
    }
    case 002:{
        SaveAllPC();
        DelayCommand(3600.0, SignalEvent(OBJECT_SELF, EventUserDefined(002)));
    }
    }
}