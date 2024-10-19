IncludeScript("ppmod3.nut");
local blue = ppmod.get("blue")
local red = ppmod.get("red")
IncludeScript("SRC/aperturekit")

Precache("music/mainmenu/portal2_background04.wav")
Precache("vo/announcer/a4_recapture01.wav")
Precache("vo/glados/gladosbattle_pre09.wav") // I hate you so much
Precache("vo/announcer/a4_recapture03.wav") // critical temp corrupted line
Precache("world/light_power_off_02.wav")
Precache("vo/wheatley/bw_a4_finale02_pipe_collapse01.wav")
Precache("weapons/rocket/rocket_locking_beep1.wav")
Precache("buttons/button_synth_negative_01.wav")
Precache("vo/wheatley/bw_a4_paradox09.wav")
Precache("vo/wheatley/bw_a4_finale04_whitegel_break01.wav")

local fadeoutlolol = entLib.CreateByClassname("env_fade", {
duration = 2, // Time for it to actually fade. (In seconds.)
holdtime = 999, // How long it lasts (In seconds.)
renderamt = 255, // Alpha.
rendercolor = "0 0 0", // Obvious.
ReverseFadeDuration = 2 // Same thing as "duration" but for the fade in.
targetname = UniqueString("scns_fadehint")
})
ppmodfade <- ppmod.get(fadeoutlolol.GetName())

local shakelol = entLib.CreateByClassname("env_shake", {
duration = 2, // How long it shakes for. (In seconds.)
frequency = 40,
amplitude = 8, // Obvious. 8 - 16
radius = 999999,
targetname = UniqueString("saltshaker")
})
ppmodshakelol <- ppmod.get(shakelol.GetName())
ppmod.fire(ppmodshakelol,"addoutput","spawnflags 4")

local shakeintense = entLib.CreateByClassname("env_shake", {
duration = 2, // How long it shakes for. (In seconds.)
frequency = 80,
amplitude = 16, // Obvious. 8 - 16
radius = 999999,
targetname = UniqueString("modified_chathintthingy")
})
ppmodshakeintense <- ppmod.get(shakeintense.GetName())
ppmod.fire(ppmodshakeintense,"addoutput","spawnflags 4")

EntFire("ambient_generic" "Kill")
EntFire("case_screen_flip" "Kill")
EntFire("counter_screen_flip" "Kill")
EntFire("movie_large" "SetMovie" "media/bluescreen.bik")
EntFire("movie_large" "Enable")

Entities.FindByName(null,"@glados").EmitSound("vo/announcer/a4_recapture01.wav")

ppmod.wait(function() {
Entities.FindByName(null,"@glados").EmitSound("vo/wheatley/bw_a4_finale02_pipe_collapse01.wav")
}4)

ppmod.wait(function() {
local explosion = entLib.CreateByClassname("env_explosion",{
    Magnitude = 5
})
explosion.SetOrigin(Vector(5121, 4598, -280))
EntFireByHandle(explosion, "Explode")
}5)

ppmod.wait(function() {
local sparkdoor = entLib.CreateByClassname("env_spark",{
    MaxDelay = 0.2,
    Magnitude = 2
})
sparkdoor.SetOrigin(Vector(5121, 4598, -302))
EntFireByHandle(sparkdoor, "StartSpark")
EntFireByHandle(sparkdoor, "StopSpark", "", 2)
EntFire("track1-prop_door_hall", "Open")
EntFire("track1-prop_door_hall", "Close", "", 1)
EntFire("track1-prop_door_hall", "Open", "", 1.5)
EntFire("track1-prop_door_hall", "Close", "", 2)
}5.3)

// ppmod.wait(function() {
// local explosiondoor2 = entLib.CreateByClassname("env_explosion",{
//     Magnitude = 5
// })
// explosiondoor2.SetOrigin(Vector(6261, 4031, -412))
// EntFireByHandle(explosiondoor2, "Explode")
// local sparkdoor2 = entLib.CreateByClassname("env_spark",{
//     MaxDelay = 0.2,
//     Magnitude = 2
// })
// sparkdoor2.SetOrigin(Vector(6261, 4031, -412))
// EntFireByHandle(sparkdoor2, "StartSpark")
// EntFireByHandle(sparkdoor2, "StopSpark", "", 2)
// EntFire("track2-prop_door_hall", "Open")
// EntFire("track2-prop_door_hall", "Close", "", 1)
// EntFire("track2-prop_door_hall", "Open", "", 1.5)
// EntFire("track2-prop_door_hall", "Close", "", 2)
// }5.3)

// ppmod.wait(function() {
// local explosiondoor3 = entLib.CreateByClassname("env_explosion",{
//     Magnitude = 5
// })
// explosiondoor3.SetOrigin(Vector(6267, 3775, 360))
// EntFireByHandle(explosiondoor3, "Explode")
// local sparkdoor3 = entLib.CreateByClassname("env_spark",{
//     MaxDelay = 0.2,
//     Magnitude = 2
// })
// sparkdoor3.SetOrigin(Vector(6267, 3775, 360))
// EntFireByHandle(sparkdoor3, "StartSpark")
// EntFireByHandle(sparkdoor3, "StopSpark", "", 2)
// EntFire("track3-prop_door_hall", "Open")
// EntFire("track3-prop_door_hall", "Close", "", 1)
// EntFire("track3-prop_door_hall", "Open", "", 1.5)
// EntFire("track3-prop_door_hall", "Close", "", 2)
// }5.3)

// ppmod.wait(function() {
// local explosiondoor4 = entLib.CreateByClassname("env_explosion",{
//     Magnitude = 5
// })
// explosiondoor4.SetOrigin(Vector(3988, 4031, -727))
// EntFireByHandle(explosiondoor4, "Explode")
// local sparkdoor4 = entLib.CreateByClassname("env_spark",{
//     MaxDelay = 0.2,
//     Magnitude = 2
// })
// sparkdoor4.SetOrigin(Vector(3988, 4031, -727))
// EntFireByHandle(sparkdoor4, "StartSpark")
// EntFireByHandle(sparkdoor4, "StopSpark", "", 2)
// EntFire("track4-prop_door_hall", "Open")
// EntFire("track4-prop_door_hall", "Close", "", 1)
// EntFire("track4-prop_door_hall", "Open", "", 1.5)
// EntFire("track4-prop_door_hall", "Close", "", 2)
// }5.3)

ppmod.wait(function() {
local explosion2 = entLib.CreateByClassname("env_explosion",{
    Magnitude = 5
})
explosion2.SetOrigin(Vector(5648, 3742, -509))
EntFireByHandle(explosion2, "Explode")
EntFire("move_catapult", "SetSpeed", "50")
EntFire("move_catapult_cover", "SetSpeed", "50")
EntFire("move_catapult", "Close", 1)
EntFire("move_catapult_cover", "Close", 1)
}11)



ppmod.wait(function() {
Entities.FindByName(null,"@glados").EmitSound("weapons/rocket/rocket_locking_beep1.wav")
}6)

ppmod.wait(function() {
Entities.FindByName(null,"@glados").EmitSound("weapons/rocket/rocket_locking_beep1.wav")
}6.50)

ppmod.wait(function() {
Entities.FindByName(null,"@glados").EmitSound("weapons/rocket/rocket_locking_beep1.wav")
}7.50)

ppmod.wait(function() {
Entities.FindByName(null,"@glados").EmitSound("buttons/button_synth_negative_01.wav")
}8.50)

ppmod.wait(function() {
Entities.FindByName(null,"@glados").EmitSound("vo/wheatley/bw_a4_paradox09.wav")
}9)

ppmod.wait(function() {
Entities.FindByName(null,"@glados").EmitSound("vo/wheatley/bw_a4_finale04_whitegel_break01.wav")
}17)

ppmod.wait(function() {
ppmod.fire(ppmodshakelol,"StartShake")
Entities.FindByName(null,"@glados").EmitSound("music/mainmenu/portal2_background04.wav")
}4)

ppmod.wait(function() {
ppmod.fire(ppmodshakelol,"StartShake")
Entities.FindByName(null,"@glados").EmitSound("vo/announcer/a4_recapture03.wav")
}10)

ppmod.interval(function(){
    local spark = entLib.CreateByClassname("env_spark",{
    Magnitude = 2
})
spark.SetOrigin(Vector(4105, 4157, 312))
EntFireByHandle(spark, "SparkOnce")

    local spark1 = entLib.CreateByClassname("env_spark",{
    Magnitude = 2
})
spark1.SetOrigin(Vector(4105, 3902, 312))
EntFireByHandle(spark1, "SparkOnce")

    local spark2 = entLib.CreateByClassname("env_spark",{
    Magnitude = 2
})
spark2.SetOrigin(Vector(4991, 2997, -536))
EntFireByHandle(spark2, "SparkOnce")
}12)

ppmod.wait(function() {
ppmod.fire(ppmodshakeintense,"StartShake")
Entities.FindByName(null,"@glados").EmitSound("world/light_power_off_02.wav")
// EntFire("env_fog_controller" "Kill")
// EntFire("@glados" "kill")
EntFire("prop_wall_projector" "disable")
EntFire("track1-math_coop_door_open" "subtract" "1")
EntFire("track1-math_coop_door_open" "kill")
EntFire("track1-blue-ballbot_assembler_relay" "kill")
EntFire("track1-orange-ballbot_assembler_relay" "kill")
EntFire("track2-math_coop_door_open" "subtract" "1")
EntFire("track2-math_coop_door_open" "kill")
EntFire("track2-blue-ballbot_assembler_relay" "kill")
EntFire("track2-orange-ballbot_assembler_relay" "kill")
EntFire("track3-math_coop_door_open" "subtract" "1")
EntFire("track3-math_coop_door_open" "kill")
EntFire("track3-blue-ballbot_assembler_relay" "kill")
EntFire("track3-orange-ballbot_assembler_relay" "kill")
EntFire("track4-math_coop_door_open" "subtract" "1")
EntFire("track4-math_coop_door_open" "kill")
EntFire("track4-blue-ballbot_assembler_relay" "kill")
EntFire("track4-orange-ballbot_assembler_relay" "kill")
EntFire("trigger_paint_door_open" "kill")
EntFire("AutoInstance1-security_3_door_right" "close")
EntFire("AutoInstance1-security_3_door_left" "close")
EntFire("track5-team_fall" "kill")
EntFire("vgui_screen" "kill")
EntFire("env_fog_controller", "SetStartDist", "-64")
EntFire("env_fog_controller", "SetEndDist", "100000", 0)
EntFire("texture_course_01", "SetTextureIndex", "0")
EntFire("texture_course_02", "SetTextureIndex", "0")
EntFire("texture_course_03", "SetTextureIndex", "0")
EntFire("texture_course_04", "SetTextureIndex", "0")
EntFire("@light_shadowed_paint", "TurnOff")
EntFire("light_shadowed_01", "TurnOff")

local spark3 = entLib.CreateByClassname("env_spark",{
    Magnitude = 5
})
spark3.SetOrigin(Vector(5114, 4574, -118))
EntFireByHandle(spark3, "SparkOnce")

local spark4 = entLib.CreateByClassname("env_spark",{
Magnitude = 2
})
spark4.SetOrigin(Vector(6259, 4026, -374))
EntFireByHandle(spark4, "SparkOnce")
}13)

ppmod.wait(function() {
local explosion3 = entLib.CreateByClassname("env_explosion",{
    Magnitude = 5
})
explosion3.SetOrigin(Vector(4436, 4328, 168))
EntFireByHandle(explosion3, "Explode")
}12)
ppmod.wait(function() {
local explosion4 = entLib.CreateByClassname("env_explosion",{
    Magnitude = 5
})
explosion4.SetOrigin(Vector(6202, 3592, -149))
EntFireByHandle(explosion4, "Explode")
}18.2)

ppmod.wait(function() {
local explosion5 = entLib.CreateByClassname("env_explosion",{
    Magnitude = 5
})
explosion5.SetOrigin(Vector(4845, 3020, -266))
EntFireByHandle(explosion5, "Explode")
}18.5)

ppmod.wait(function() {
local explosion6 = entLib.CreateByClassname("env_explosion",{
    Magnitude = 5
})
explosion6.SetOrigin(Vector(4786, 4925, -600))
EntFireByHandle(explosion6, "Explode")
}18.7)

ppmod.wait(function() {
local explosion7 = entLib.CreateByClassname("env_explosion",{
    Magnitude = 5
})
explosion7.SetOrigin(Vector(4810, 4573, 604))
EntFireByHandle(explosion7, "Explode")
}16)

max <- 100
ppmod.wait(function() {
ppmod.interval(function(){
if (max > 80)
{
local explosionmany = entLib.CreateByClassname("env_explosion",{
    Magnitude = 5
})
local random = RandomInt(1, 2)
if (random == 1)
{
explosionmany.SetOrigin(blue.GetOrigin() + Vector(RandomInt(1, 500), RandomInt(1, 500), RandomInt(1, 500)))
}
if (random == 2)
{
    explosionmany.SetOrigin(red.GetOrigin() + Vector(RandomInt(1, 500), RandomInt(1, 500), RandomInt(1, 500)))
}
EntFireByHandle(explosionmany, "Explode")
max = max - 1
printl("Max: " + max)
}
}0.3)
}19)




fogdist <- 50000

ppmod.wait(function() {
ppmod.interval(function(){
if (fogdist > 20 && fogdist > 3000)
{
    fogdist = fogdist - 150;
}
if (fogdist > 20 && fogdist <= 3000)
{
    EntFire("weapon_portalgun", "kill")
    EntFire("prop_portal", "Fizzle")
    fogdist = fogdist - 10;
}
EntFire("env_fog_controller", "SetEndDist", fogdist, 0)
// printl("Fogdist: " + fogdist)
})
EntFire("env_fog_controller", "SetStartDist", "-64")
EntFire("env_fog_controller", "SetColorSecondary", "255 255 255")
EntFire("env_fog_controller", "SetColor", "255 255 255")
Precache("playonce/level/animation_sfx/finale3_wall_collapse.wav")
blue.EmitSound("playonce/level/animation_sfx/finale3_wall_collapse.wav")
// ppmod.fire(ppmodfade,"Fade")
}20)

ppmod.wait(function() {
Precache("playonce/level/animation_sfx/finale3_destruction01.wav")
blue.EmitSound("playonce/level/animation_sfx/finale3_destruction01.wav")
}25)

ppmod.wait(function() {
    local launchplayerup = function(player1,upforce) {
    local targetplayer = player1
    local targetplayervelocity = targetplayer.GetVelocity()
    targetplayer.SetVelocity(Vector(targetplayervelocity.x,targetplayervelocity.y,upforce))
}
ppmod.player(blue).then(function (pplayer) {

    // Note: this will fire for every +attack input, even if the player can't shoot portals
    pplayer.gravity(0.2)

  });

ppmod.player(red).then(function (pplayer) {

    // Note: this will fire for every +attack input, even if the player can't shoot portals
    pplayer.gravity(0.2)

  });
launchplayerup(blue,500)
launchplayerup(red,500)
}26)

ppmod.wait(function() {
ppmod.fire(ppmodfade,"Fade")
// SendToConsole("disconnect")
}35)