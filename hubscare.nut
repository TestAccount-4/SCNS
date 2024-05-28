IncludeScript("ppmod3.nut");
IncludeScript("SRC/aperturekit")
local blue = ppmod.get("blue")
Precache("vfx/bridge_glow_lp_01.wav")

blue.EmitSound("vfx/bridge_glow_lp_01.wav")

EntFire("ambient_generic" "kill")
EntFire("env_fog_controller" "kill")
EntFire("@glados" "kill")
EntFire("timer_swap_screens" "kill")
EntFire("relay_screen_flip_panels" "kill")
EntFire("prop_wall_projector" "disable")
EntFire("track5-light_off" "disable")
EntFire("track5-light_off" "kill")
EntFire("track5-light_on" "enable")
EntFire("track5-light_on" "kill")
EntFire("vgui_screen" "kill")
EntFire("move_paint_track entrance","kill")

EntFire("track1-math_coop_door_open" "subtract" "1")
EntFire("track1-math_coop_door_open" "kill")
EntFire("track2-math_coop_door_open" "subtract" "1")
EntFire("track2-math_coop_door_open" "kill")
EntFire("track3-math_coop_door_open" "subtract" "1")
EntFire("track3-math_coop_door_open" "kill")
EntFire("track4-math_coop_door_open" "subtract" "1")
EntFire("track4-math_coop_door_open" "kill")
EntFire("dlc_transport_sheath" "close")
EntFire("track6-math_coop_door_open" "subtract" "1")
EntFire("track6-math_coop_door_open" "kill")

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