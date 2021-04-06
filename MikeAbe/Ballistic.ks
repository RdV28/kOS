// Ballistic Script 

// @author: Mike Aben (2019)
// @param: heading, pitch

// DESCRIPTION:
// Takes a parameters for desired 
// heading [0 , 360) & pitch (0, 90].
// Executes primary ignition and launch.
// Will pitch over towards a target pitch
// and lock to that pitch, afterwhich 
// program terminates.

   // parameters
PARAMETER desiredHeading.
PARAMETER desiredPitch.	

   // Desired altitude to begin pitching over.
SET pitchStartingAlt to 250. 
   // Roll correction
SET rollCorrection to 360 - desiredHeading.

WAIT 2.
CLEARSCREEN. 

countdown.
pitchManuever.
lockToPrograde.

//END PROGRAM

//**********************************

   // Vessel pitch
FUNCTION vpitch {
   RETURN 90 - VANG(UP:FOREVECTOR, FACING:FOREVECTOR).
}

   // Pitch setting
FUNCTION myPitch {
   RETURN 900000 / (ALTITUDE*(90/desiredPitch - 1) + 10000).
}

   //COUNTDOWN
FUNCTION countdown {
   PRINT "5".
   WAIT 1. 
   PRINT "4".
   WAIT 1. 
   PRINT "3".
   WAIT 0.5.
   LOCK STEERING to UP + R(0, 0, 180).
   PRINT "Locking attitude control.".
   WAIT 0.5. 
   PRINT "2".
   WAIT 1. 
   PRINT "1".
   WAIT 1. 
   STAGE.
   PRINT "LAUNCH!".
}

   //PITCHING MANEUVER
FUNCTION pitchManuever {
   WAIT UNTIL (ALTITUDE > pitchStartingAlt).
   PRINT " ". 
   PRINT "Starting pitching maneuver.".

   UNTIL (abs(desiredPitch - vPitch) < 5) {
      LOCK STEERING to HEADING(desiredHeading, myPitch)+ R(0, 0, rollCorrection).
   }
}

   //LOCKING TO PROGRADE
FUNCTION lockToPrograde {
   PRINT " ". 
   PRINT "Desired pitch reached.".
   PRINT "Locking to prograde.".
   LOCK STEERING to SRFPROGRADE + R(0, 0, rollCorrection).

   WAIT 5.

   PRINT " ".
   PRINT "Lock disengaged.".
   PRINT "Going ballistic.".
}