IncludeScript("ppmod3.nut");
IncludeScript("SRC/aperturekit")
local blue = ppmod.get("blue")
Precache("vfx/bridge_glow_lp_01.wav")

blue.EmitSound("vfx/bridge_glow_lp_01.wav")

EntFire("ambient_generic" "kill")
// EntFire("env_fog_controller" "kill")
EntFire("@glados" "kill")
EntFire("timer_swap_screens" "kill")
EntFire("relay_screen_flip_panels" "kill")
EntFire("prop_wall_projector" "disable")
EntFire("track5-light_off" "disable")
EntFire("track5-light_off" "kill")
EntFire("track5-light_on" "enable")
EntFire("track5-light_on" "kill")
EntFire("texture_course_01", "SetTextureIndex", "0")
EntFire("texture_course_02", "SetTextureIndex", "0")
EntFire("texture_course_03", "SetTextureIndex", "0")
EntFire("texture_course_04", "SetTextureIndex", "0")
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

EntFire("weapon_portalgun", "kill")
EntFire("prop_portal", "Fizzle")
EntFire("trigger_hurt", "Disable")
EntFire("@global_no_pinging_blue", "TurnOn")
EntFire("@global_no_pinging_orange", "TurnOn")
EntFire("@global_no_taunting_blue", "TurnOn")
EntFire("@global_no_taunting_orange", "TurnOn")
// EntFire("env_fog_controller", "SetEndDist", "400", 0.3)

EntFire("env_fog_controller", "SetColorSecondary", "70 75 80")
EntFire("env_fog_controller", "SetColor", "70 75 80")
// EntFire("env_fog_controller", "SetStartDist", "-64")
// EntFire("env_fog_controller", "SetEndDist", "186")
EntFire("env_fog_controller", "SetMaxDensity", 1)

fogdist <- 5000
startdist <-- 64
fogcol1 <- 70
fogcol2 <- 75
fogcol3 <- 80

ppmod.interval(function(){
        if (fogdist > 20 && fogdist > 1000)
        {
        fogdist = fogdist - 20;
        }
        if (fogdist > 300 && fogdist <= 1000)
        {
            if (fogcol1 > 0)
            {
            fogcol1 = fogcol1 - 5
            }
            if (fogcol2 > 0)
            {
            fogcol2 = fogcol2 - 5
            }
            if (fogcol3 > 0)
            {
            fogcol3 = fogcol3 - 5
            }
            EntFire("env_fog_controller", "SetColor", fogcol1 + " " + fogcol2 + " " + fogcol3)
            fogdist = fogdist - 10;
        }
        if (fogdist > 20 && fogdist <= 300)
        {
            fogdist = fogdist - 5;
        }
        if (fogdist == 20)
        {
        ppmod.wait(function(){
            Precache("playonce/scripted_sequences/shoot_the_moon_sweep_01.wav")
            Precache("ambient/fire/amb_fireball_flyby_01.wav")
            Precache("ambient/fire/amb_fireball_flyby_02.wav")
            blue.EmitSound("playonce/scripted_sequences/shoot_the_moon_sweep_01.wav")
            EntFire("blue", "SetHealth", "-100", 7.00)
            EntFire("red", "SetHealth", "-100", 7.00)
        },5.1)
        ppmod.wait(function(){
            blue.EmitSound("ambient/fire/amb_fireball_flyby_01.wav")
        },7.0)
        ppmod.wait(function(){
            blue.EmitSound("ambient/fire/amb_fireball_flyby_01.wav")
        },8.0)
        ppmod.wait(function(){
            blue.EmitSound("ambient/fire/amb_fireball_flyby_01.wav")
        },9.0)
        ppmod.wait(function(){
            blue.EmitSound("ambient/fire/amb_fireball_flyby_01.wav")
        },10.0)
        ppmod.wait(function(){
            blue.EmitSound("ambient/fire/amb_fireball_flyby_02.wav")
            EntFire("env_fade", "AddOutput", "duration 0")
            // local scareturret = ppmod.create("npc_portal_turret_floor").then(function (scareturret) {
            // scareturret.SetOrigin(FindByEntIndex(1).GetOrigin() + Vector(70, 0, 30));
            // scareturret.SetAngles(0, -180, 0)
            // ppmod.keyval(scareturret,"spawnflags","64256");
            // ppmod.keyval(scareturret,"gagged","1");
            // EntFireByHandle(scareturret, "SetParent", "blue")
            // EntFireByHandle(scareturret, "AddOutput", "MoveType 8")
            // EntFireByHandle(scareturret, "Color", "0, 0, 0")
            // EntFireByHandle(scareturret, "Enable", "", 1)
            // EntFireByHandle(scareturret, "Kill", "", 2)
            // })
        },11.0)
        ppmod.wait(function(){
            ppmod.fire(ppmodhint,"EndHint")
            EntFire("env_fade", "Fade", "", 0)
            EntFire("@command", "command", "changelevel mp_coop_laser_crusher", 3)
            // laser_crusher is the scariest map because it has 3 reuses of the same BTS wall and a turretLaser_laser_1 
            Precache("playonce/scripted_sequences/a3_03_atom_impact.wav")
            blue.EmitSound("playonce/scripted_sequences/a3_03_atom_impact.wav")
        },12.0)
        fogdist = 19
        }
        EntFire("env_fog_controller", "SetStartDist", startdist)
        EntFire("env_fog_controller", "SetEndDist", fogdist, 0)
        printl("Fogdist: " + fogdist)
        printl("Startdist: " + startdist)
    },0.2)

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