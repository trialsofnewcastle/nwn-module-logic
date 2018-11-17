#include "_save"

void main()
{
switch (GetUserDefinedEventNumber()) 
    {
        case 001:{
            SpeakString("Scheduled Shouting", TALKVOLUME_SHOUT);
            SpeakString("Prolly wanna change this.", TALKVOLUME_SHOUT);
            DelayCommand(5400.0, SignalEvent(OBJECT_SELF, EventUserDefined(001)));
            break;
        }
        case 002:{
            MasterSave();
            DelayCommand(3600.0, SignalEvent(OBJECT_SELF, EventUserDefined(002)));
        }
    }
}