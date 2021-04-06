core:part:getmodule("kOSprocessor"):doevent("open terminal").

print "KSP V1.11.1".
print "SC_boot_Minmus.ks".

if (Ship:status = "PRELAUNCH") {
    Copypath("0:/SpaceCore/Countdown.ks","1:/SpaceCore/Countdown.ks").
    copypath("0:/SpaceCore/Liftoff.ks","1:/SpaceCore/Liftoff.ks").
    copypath("0:/SpaceCore/Launch_minmus.ks","1:/SpaceCore/Launch_minmus.ks").
    copypath("0:/SpaceCore/MinmusLaunchOpp.ks","1:/SpaceCore/MinmusLaunchOpp.ks").
    copypath("0:/SpaceCore/Ascent.ks","1:/SpaceCore/Ascent.ks").
}

copypath("0:/SpaceCore/CircToAp.ks","1:/SpaceCore/CircToAp.ks").
copypath("0:/SpaceCore/CircToPe.ks","1:/SpaceCore/CircToPe.ks").
copypath("0:/SpaceCore/ExeNode.ks","1:/SpaceCore/ExeNode.ks").

switch to 1.
cd("/SpaceCore").

if (Ship:status = "PRELAUNCH") {
    run MinmusLaunchOpp.
}