// Hover Script 

// @author: Mike Aben (2019)

// DESCRIPTION:
// Designed for a powered, vertical landing
// vehicle. Takes a parameter altitude and
// adjust thrust to maintain.

SET thrustSetting to 0.
SET thrustAdj to 0.
SET incr to 0.05.
SET fudge to 0.9735.

WAIT UNTIL AVAILABLETHRUST > 0.

LOCK THROTTLE to thrustSetting*thrustAdj.
LOCK Fg to (BODY:MU/BODY:RADIUS^2)*MASS.
LOCK vAngle to VANG(SHIP:FACING:FOREVECTOR, SHIP:UP:FOREVECTOR).
LOCK thrustSetting to fudge*Fg / COS(vAngle) / AVAILABLETHRUST.
SET ch to "".

WHEN ch = TERMINAL:INPUT:UPCURSORONE THEN {
   SET ch to "".
   SET thrustAdj to thrustAdj + incr.
   RETURN true.
}
WHEN ch = TERMINAL:INPUT:DOWNCURSORONE THEN {
   SET ch to "".
   SET thrustAdj to thrustAdj - incr.
   RETURN true.
}
WHEN ch = TERMINAL:INPUT:HOMECURSOR THEN {
   SET ch to "".
   SET thrustAdj to 1.
   RETURN true.
}
WHEN ch = TERMINAL:INPUT:ENDCURSOR THEN {
   SET ch to "".
   SET thrustAdj to 0.
   RETURN true.
}

UNTIL ch = TERMINAL:INPUT:DELETERIGHT {
   CLEARSCREEN.
   PRINT "CONTROLS:".
   PRINT "Home: Hover Mode".
   PRINT "End: Kill Throttle".
   PRINT "Up Cursor: Increase Throttle 5%".
   PRINT "Down Cursor: Decrease Throttle 5%".
   PRINT "Delete: End Program".
   PRINT " ".
   PRINT "THRUST ADJUSTMENT: " + thrustAdj.
   IF thrustAdj = 1 {
      PRINT "HOVER MODE".
   }
   IF thrustAdj = 0 {
      PRINT "THROTTLE KILLED".
   }
   SET ch to TERMINAL:INPUT:GETCHAR().
   WAIT 0.01.
}
