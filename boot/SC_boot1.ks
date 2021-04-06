core:part:getmodule("kOSprocessor"):doevent("open terminal").

print "KSP V1.11.1".
print "SC_boot1.ks".

Copypath("0:/SpaceCore/Countdown.ks","1:/SpaceCore/Countdown.ks").
copypath("0:/SpaceCore/Liftoff.ks","1:/SpaceCore/Liftoff.ks").
copypath("0:/SpaceCore/Ascent.ks","1:/SpaceCore/Ascent.ks").
copypath("0:/SpaceCore/CircToAp.ks","1:/SpaceCore/CircToAp.ks").
copypath("0:/SpaceCore/Launch.ks","1:/SpaceCore/Launch.ks").
copypath("0:/SpaceCore/ExeNode.ks","1:/SpaceCore/ExeNode.ks").
switch to 1.
cd("/SpaceCore").
print "use RUN Launch( false, 90, +6, 70 ).".