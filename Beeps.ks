
//**********************************

SET voice to getVoice(0).
SET voiceTickNote to NOTE(480, 0.1).
SET voiceTakeOffNote to NOTE(720, 0.5).

FUNCTION countdown {
   SAS OFF.
   PRINT "5".
   voice:PLAY(voiceTickNote).
   WAIT 1. 
   PRINT "4".
   voice:PLAY(voiceTickNote).
   WAIT 1. 
   PRINT "3".
   voice:PLAY(voiceTickNote).
   WAIT 0.5.
   LOCK STEERING to UP + R(0, 0, 180).
   PRINT "Locking attitude control.".
   WAIT 0.5. 
   PRINT "2".
   voice:PLAY(voiceTickNote).
   WAIT 0.5. 
   LOCK THROTTLE to 1.
   WAIT 0.5.
   PRINT "Throttle to full.".
   PRINT "1".
   voice:PLAY(voiceTickNote).
   PRINT "IGNITION".
   STAGE.
         // checking for subnominal thrust
FUNCTION countdown {
      WAIT 1. 
      STAGE.
      PRINT "LAUNCH!".
      voice:PLAY(voiceTakeOffNote).
      WAIT 0.1.
   }  
   WAIT 2.
    FUNCTION endBurn {
   WAIT 2.
}

///END OF PROGRAM 
///END OF PROGRAM