// Hover Script 

// @author: Mike Aben (2019)

// DESCRIPTION:
// Designed for a powered, vertical landing
// vehicle. Provides a UI to allow easier
// controlling of thrust.

   //Vehicle TWR
SET thrustAdj to 0.   
   //increase/decrease increment percentage
SET incr to 0.05.     

main().

//***************************************************
 
   //main program
FUNCTION main {
   setThrust().
   setTriggers().
   printUI().
}

   //controls the thrust of the vehicle
FUNCTION setThrust {
   WAIT UNTIL AVAILABLETHRUST > 0.  //waiting for engines to be on
   LOCK THROTTLE to thrustSetting.  //force of gravity on vessel
   LOCK Fg to (BODY:MU/(BODY:RADIUS+ALTITUDE)^2)*MASS. //vertical component of Fg
   LOCK vAngle to VANG(SHIP:FACING:FOREVECTOR, SHIP:UP:FOREVECTOR). //locks thrust
   LOCK thrustSetting to thrustAdj*Fg / COS(vAngle) / AVAILABLETHRUST.
}

   //sets triggers to action groups
FUNCTION setTriggers {
      //increases thrust
   ON AG6 {
      SET thrustAdj to thrustAdj + incr.
      RETURN true.
   }
      //decreases thrust
   ON AG5 {
      SET thrustAdj to thrustAdj - incr.
      RETURN true.
   }
      //sets TWR to 1
   ON AG9 {
      SET thrustAdj to 1.
      RETURN true.
   }
      //kills engines
   ON AG10 {
      SET thrustAdj to 0.
      RETURN true.
   }
}
 
   //prints user interface
FUNCTION printUI {
   UNTIL AG1 {
      CLEARSCREEN.
      PRINT "CONTROLS:".
      PRINT "AG9: Hover Mode".
      PRINT "AG10: Kill Throttle".
      PRINT "AG6: Increase Throttle 5%".
      PRINT "AG5: Decrease Throttle 5%".
      PRINT "AG1: End Program".
      PRINT " ".
      PRINT "TWR: " + thrustAdj.
      IF thrustAdj = 1 {
         PRINT "HOVER MODE".
      }
      IF thrustAdj = 0 {
         PRINT "THROTTLE KILLED".
      }
      PRINT " ".
      WAIT 0.01.
   }
}

//END OF PROGRAM
