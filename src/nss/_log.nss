#include "mod_webhook"


void Log(string sMessage, string sLogLevel)
{
    WriteTimestampedLogEntry(sMessage);
    SendbWebhook("debug", sMessage, sLogLevel);
}
