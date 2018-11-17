#include "nwnx_redis_ps"
#include "nwnx_redis"
#include "_log"
#include "_save"

#include "mod_player_event"

void ReturnOkay(string sPSChannel, string sPSMessage)
{
  if(sPSMessage == "uuid")
  {
    SetLocalInt(GetModule(),"uuidinprogress",0);
    WriteTimestampedLogEntry("Pubsub Heartbeat Event: "+sPSMessage);
  }
}

void Heartbeat(string sPSChannel, string sPSMessage)
{
  if(sPSMessage == "1m")
  {
    WriteTimestampedLogEntry("Pubsub Heartbeat Event: "+sPSMessage);
  }

  if(sPSMessage == "5m")
  {
    WriteTimestampedLogEntry("Pubsub Heartbeat Event: "+sPSMessage);
  }

  if(sPSMessage == "30m")
  {
    WriteTimestampedLogEntry("Pubsub Heartbeat Event: "+sPSMessage);
  }

  if(sPSMessage == "1h")
  {
    WriteTimestampedLogEntry("Pubsub Heartbeat Event: "+sPSMessage);
  }

  if(sPSMessage == "6h")
  {
    WriteTimestampedLogEntry("Pubsub Heartbeat Event: "+sPSMessage);
  }

  if(sPSMessage == "12h")
  {
    WriteTimestampedLogEntry("Pubsub Heartbeat Event: "+sPSMessage);
  }

  if(sPSMessage == "24h")
  {
    WriteTimestampedLogEntry("Pubsub Heartbeat Event: "+sPSMessage);
  }
}

void ContinuousIntegration(string sPSChannel, string sPSMessage)
{
  if(sPSMessage == "repoupdate")
  {
    WriteTimestampedLogEntry("Pubsub Event: repo has been updated");

  }
}
void main()
{
  struct NWNX_Redis_PubSubMessageData data = NWNX_Redis_GetPubSubMessageData();

  if(data.channel == "return" && data.message == "uuid")
  {
    ReturnOkay(data.channel, data.message);
    WriteTimestampedLogEntry("Pubsub Event: channel=" + data.channel + " message=" + data.message);
  }

  if(data.channel == "heartbeat")
  {
    Heartbeat(data.channel, data.message);
    WriteTimestampedLogEntry("Pubsub Event: channel=" + data.channel + " message=" + data.message);
  }

  if(data.channel == "ci")
  {
    ContinuousIntegration(data.channel, data.message);
    WriteTimestampedLogEntry("Pubsub Event: channel=" + data.channel + " message=" + data.message);
  }

}
