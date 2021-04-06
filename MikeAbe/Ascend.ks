// Ascent Script 

// @author: Mike Aben (2019)
// @param: inclination, apoapsis

// DESCRIPTION:
// Takes parameters for desired 
// inclination (-180 to 180] (negative
// is south), & apoapsis (in km).
// Executes primary ignition and launch.
// Will pitch over in appropriate heading
// to achieve desired inclination.
// Cuts throttle when desired apoapsis
// is reached and ends program at hard
// coded altitude.

   // parameters
PARAMETER desiredInclination.
PARAMETER desiredApoapsis.	

   // Desired altitude to begin pitching maneuver.
SET pitchStartingAlt to 250. 
   // Desired altitude to extend deployables.
SET deployAlt to 60000.
   // Value of thrust before staging.
SET oldThrust to 0.

main().

//**********************************

   // Main program
FUNCTION main {
   WAIT 2.
   CLEARSCREEN. 
   countdown().
   pitchManuever().
   SET oldThrust to AVAILABLETHRUST.
   autoStage().
   meco().
   lockToPrograde().
   autoDeploy().
}

   // Pitch setting
FUNCTION myPitch {
   RETURN 900000 / (ALTITUDE + 10000).
   // RETURN (54021666.2 - ALTITUDE)/sqrt(2918700708000000-(ALTITUDE - 54021666.2)^2).
}

   // Roll setting
FUNCTION myRoll {
   RETURN 360 - myHeading.
}

   //Heading setting
FUNCTION myHeading {
   SET roughHeading to 90 - desiredInclination.
   IF (roughHeading < 0) {
      SET roughHeading to 360 + roughHeading.
   }
      //taking into account Kerbin's rotation
   SET triAng to abs(90 - roughHeading).
   SET dV to sqrt(6688800 - 928800*cos(triAng)).
   SET correction to arcsin(180*sin(triAng) / dV).
   IF (desiredInclination > 0) {
      SET correction to -1*correction.
   }
   
   RETURN roughHeading + correction.
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
   WAIT 0.5. 
   LOCK THROTTLE to 1.
   PRINT "Throttle to full.".
   WAIT 0.5.
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
   LOCK STEERING to HEADING(myHeading(), myPitch())+ R(0, 0, myRoll()).
}

   //LOCKING TO PROGRADE
FUNCTION lockToPrograde {
   PRINT "Locking to prograde.".
   LOCK STEERING to SRFPROGRADE + R(0, 0, myRoll()).
}

   //Main Engine Cut-off
FUNCTION meco {
   LOCK THROTTLE to 0.
   PRINT " ".
   PRINT "MECO.".
}

   //Stages of engine thrust drops.
FUNCTION autoStage {
   UNTIL (APOAPSIS > desiredApoapsis*1000) {
      IF (AVAILABLETHRUST < (oldThrust - 10)) {
         STAGE.
         PRINT " ".
         PRINT "Staging".
         WAIT 1.
         SET oldThrust to AVAILABLETHRUST.
      }
   }
}   
   //Stages fairings and deploys equipment
FUNCTION autoDeploy {
   SET fairing to false.      //holds if vessel has a fairing
   LIST PARTS IN partList.    //LIST of parts on vessel
   WAIT UNTIL (ALTITUDE > deployAlt).
   FOR part IN partList {     //checks if fairing in partList
      IF (part:NAME = "fairingSize1" OR
	      part:NAME = "fairingSize2" OR
		  part:NAME = "fairingSize3" OR
		  part:NAME = "restock-fairing-base-0625-1" OR
		  part:NAME = "restock-fairing-base-1875-1" OR
		  part:NAME = "fairingSize1p5" OR
		  part:NAME = "fairingSize4") {
		     SET fairing to true.
			 BREAK.
		  }
   }                         //stages if vessel has a fairing
   IF fairing {
      STAGE.
	  PRINT " ".
	  PRINT "Staging Fairing.".
   }
   WAIT 5.
        //all deployable equipment must be on action group 10
   AG10 ON.
   PRINT " ".
   PRINT "Extending deployable equipment.".
   PRINT " ".
   PRINT "Attitude lock disengaged.".
   WAIT 5.
   PRINT " ".
}

/// END OF PROGRAM