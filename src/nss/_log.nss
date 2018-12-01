#include "mod_webhook"


void Log(string sMessage, string sLogLevel){
    WriteTimestampedLogEntry("Logging: " + sMessage + " | Level: " + sLogLevel);
    
    int nLogLevel = StringToInt(sLogLevel);
    switch (nLogLevel) 
    {   
    case 0:
        SendbWebhook("debug", sMessage, sLogLevel);
        break;
    case 1:
        SendbWebhook("public", sMessage, sLogLevel);
        break;   
    case 2:
        SendbWebhook("private", sMessage, sLogLevel);
        break;
    }
}
