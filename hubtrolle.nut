IncludeScript("ppmod3.nut");
IncludeScript("SRC/aperturekit")
local blue = ppmod.get("blue")
Precache("vfx/bridge_glow_lp_01.wav")

blue.EmitSound("vfx/bridge_glow_lp_01.wav")

EntFire("ambient_generic" "kill")
EntFire("env_fog_controller" "kill")
EntFire("env_fade" "kill")
EntFire("@glados" "kill")
EntFire("vgui_screen" "kill")
EntFire("timer_swap_screens" "kill") // just incase
EntFire("relay_screen_flip_panels" "kill") // just just incase
EntFire("trigger_hurt" "kill") // bad solution, but idk anything else I could do to keep the fadeout

EntFire("prop_wall_projector" "disable")

EntFire("track5-light_off" "disable")
EntFire("track5-light_off" "kill")
EntFire("track5-light_on" "enable")
EntFire("track5-light_on" "kill")

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

EntFire("dlc_transport_sheath" "close") // art therapy movelinear thingymabob

EntFire("track6-math_coop_door_open" "subtract" "1")
EntFire("track6-math_coop_door_open" "kill")
EntFire("track6-blue-ballbot_assembler_relay" "kill")
EntFire("track6-orange-ballbot_assembler_relay" "kill")

local hint = entLib.CreateByClassname("env_instructor_hint", {
hint_allow_nodraw_target = 1,
hint_forcecaption = 1,
hint_caption = "RUN." 				// Caption, should be obvious enough.
hint_color = "255 0 0",
hint_icon_offscreen = "icon_arrow_plain",
hint_icon_onscreen = "icon_skull",			// Icon that shows to the left of the caption. (Check VDC!)
hint_timeout = 960, 					// How long the hint is on screen for. (In seconds.)
hint_pulseoption = 1,
hint_shakeoption = 2,
hint_static = 1, 					// 0 = follows target, 1 = static
targetname = UniqueString("scns_chathint_which_I_stole_lol")
})
ppmodhint <- ppmod.get(hint.GetName())
ppmod.fire(ppmodhint,"ShowHint")

local fadeoutlolol = entLib.CreateByClassname("env_fade", {
duration = 20, // Time for it to actually fade. (In seconds.)
radius = 999, // How long it lasts (In seconds.)
renderamt = 255, // Alpha.
rendercolor = "0 0 0", // Obvious.
ReverseFadeDuration = 2 // Same thing as "duration" but for the fade in.
targetname = UniqueString("scns_chathint_but_I_modified_it")
})
ppmodfade <- ppmod.get(fadeoutlolol.GetName())
ppmod.fire(ppmodfade,"Fade")

ppmod.wait(function() {
SendToConsole("disconnect aaa")
}25)