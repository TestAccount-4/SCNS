IncludeScript("ppmod3.nut");
local blue = ppmod.get("blue")
local red = ppmod.get("red")
IncludeScript("SRC/aperturekit")

Precache("music/mainmenu/portal2_background04.wav")
Precache("vo/announcer/a4_recapture01.wav")
Precache("vo/glados/gladosbattle_pre09.wav") // I hate you so much
Precache("vo/announcer/a4_recapture03.wav") // critical temp corrupted line
Precache("world/light_power_off_02.wav")

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
Entities.FindByName(null,"@glados").EmitSound("vo/glados/gladosbattle_pre09.wav")
}4)

ppmod.wait(function() {
ppmod.fire(ppmodshakelol,"StartShake")
Entities.FindByName(null,"@glados").EmitSound("music/mainmenu/portal2_background04.wav")
}2)

ppmod.wait(function() {
ppmod.fire(ppmodshakelol,"StartShake")
Entities.FindByName(null,"@glados").EmitSound("vo/announcer/a4_recapture03.wav")
}8)

ppmod.wait(function() {
ppmod.fire(ppmodshakeintense,"StartShake")
Entities.FindByName(null,"@glados").EmitSound("world/light_power_off_02.wav")
EntFire("env_fog_controller" "Kill")
EntFire("@glados" "kill")
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
}11)

ppmod.wait(function() {
ppmod.fire(ppmodfade,"Fade")
}18)

ppmod.wait(function() {
SendToConsole("disconnect")
}22)