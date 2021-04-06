// Basic Suborbital Script

// @author: Mike Aben (2019)

// DESCRIPTION:
// Executes primary ignition and launch.
// Will pitch eastward after hard coded altitude
// is reached and then locks on prograde,
// afterwhich program will terminate.

	// Desired altitude to begin pitching over.
SET pitchStartingAlt to 1000. 

WAIT 2.
CLEARSCREEN. 

	//COUNTDOWN
PRINT "5".
WAIT 1. 
PRINT "4".
WAIT 1. 
PRINT "3".
	//ATTITUDE CONTROL
LOCK STEERING to UP + R(0, 0, 180).
PRINT "Locking attitude control.".
WAIT 1. 
PRINT "2".
WAIT 1. 
PRINT "1".

WAIT 1. STAGE.
PRINT "LAUNCH!".

	//PITCHING MANEUVER
WAIT UNTIL (ALTITUDE > pitchStartingAlt).
LOCK STEERING to HEADING(90, 80) + R(0, 0, 270).
PRINT " ". 
PRINT "Pitch east 10 degrees.".
WAIT 5.

	//LOCK TO PROGRADE
PRINT " ". 
PRINT "Locking to prograde.".
LOCK STEERING to SRFPROGRADE + R(0, 0, 270).

WAIT 5.

//END PROGRAM