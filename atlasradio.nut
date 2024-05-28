IncludeScript("ppmod3.nut");
local blue = ppmod.get("blue")
local red = ppmod.get("red")
IncludeScript("SRC/aperturekit")
Precache("vo/glados/chellgladoswakeup06.wav")
Precache("music/sp_a4_finale4_b0.wav")
Precache("music/sp_a4_finale4_b1.wav")
Precache("music/sp_a4_finale4_b2.wav") //start of actual fight
Precache("music/sp_a4_finale4_b3.wav")
Precache("music/sp_a4_finale4_b4.wav")
Precache("music/sp_a4_finale4_b5.wav")
Precache("music/sp_a4_finale4_b6.wav")
Precache("music/sp_a4_finale4_b7.wav")
Precache("music/sp_a4_finale4_b8.wav")
Precache("music/sp_a4_finale4_b9.wav")
Precache("music/sp_a4_finale4_b10.wav")
Precache("music/sp_a4_finale4_b11.wav")
Precache("music/sp_a4_finale4_b12.wav")
Precache("vo/cavejohnson/fifties_elevator_out_a01.wav")
Precache("music/mainmenu/portal2_background01.wav") //start
Precache("music/mainmenu/portal2_background02.wav") //ground things go into fire or whatever
Precache("music/mainmenu/portal2_background03.wav") //we are underground
Precache("music/mainmenu/portal2_background04.wav") //wheatley is in control
Precache("music/mainmenu/portal2_background05.wav") //wheatley beat game
Precache("music/portal2_want_you_gone.wav")
Precache("gladoswakeup/hackbuzzer.wav")
Precache("labs/potato_timer_01.wav")
Precache("vo/wheatley/bw_a4_big_idea01.wav") //he feels really good
Precache("music/portal2_robots_ftw.wav")
Precache("music/sp_under_potatos_v1_01.wav")
Precache("music/sp_under_potatos_x1_01.wav")
Precache("vo/core03/spaceresponse05.wav")
Precache("vo/core01/space19.wav")
Precache("vo/core01/space20.wav")
Precache("vo/core01/space21.wav")
Precache("vo/core01/space22.wav")
Precache("vo/core02/attachedfact18.wav")
Precache("vo/core02/attachedfact19.wav")
Precache("vo/core02/attachedfact20.wav")
Precache("vo/core02/attachedfact21.wav")
Precache("vo/core02/attachedfact22.wav")
Precache("vo/glados/anti_taunt01.wav")
Precache("vo/glados/anti_taunt02.wav")
Precache("vo/glados/anti_taunt03.wav")
Precache("vo/glados/anti_taunt04.wav")
Precache("vo/glados/anti_taunt05.wav")
Precache("vo/glados/anti_taunt06.wav")
Precache("vo/glados/anti_taunt07.wav")
Precache("vo/glados/anti_taunt08.wav")
Precache("vo/glados/anti_taunt09.wav")
Precache("vo/glados/anti_taunt10.wav")
Precache("vo/glados/anti_taunt11.wav")
Precache("vo/glados/anti_taunt12.wav")
Precache("vo/glados/anti_taunt13.wav")
Precache("vo/glados/anti_taunt14.wav")
Precache("vo/glados/anti_taunt15.wav")
Precache("vo/glados/anti_taunt16.wav")
Precache("vo/glados/anti_taunt17.wav")
Precache("vo/glados/anti_taunt18.wav")
Precache("vo/glados/anti_taunt19.wav")
Precache("vo/glados/anti_taunt20.wav")
Precache("vo/glados/anti_taunt21.wav")
Precache("vo/glados/anti_taunt22.wav")
Precache("vo/glados/anti_taunt23.wav")
Precache("music/sp_a2_bts1_x1.wav")
Precache("ambient/music/looping_radio_mix.wav")
Precache("playonce/level/animation_sfx/vault_door_open.wav")
PlaySound <- function(sound = "error.wav") {
    IncludeScript("SRC/aperturekit")
    if (sound == "radio") {
        local sounda = "ambient/music/looping_radio_mix.wav"
    } else if (sound == "correct") {
        local sounda = "labs/potato_timer_01.wav"
    } else if (sound == "incorrect") {
        local sounda = "gladoswakeup/hackbuzzer.wav"
    } else if (sound == "want_you_gone"||sound == "want you gone"||sound == "wyg") {
        local sounda = "music/portal2_want_you_gone.wav"
    } else if (sound == "robots_ftw"||sound == "ftw") {
        local sounda = "music/portal2_robots_ftw.wav"
    } else if (sound == "reallygood") {
        local sounda = "vo/wheatley/bw_a4_big_idea01.wav"
    } else if ("finale0") {
        local sounda = "music/sp_a4_finale4_b0.wav"
    } else if ("finale1") {
        local sounda = "music/sp_a4_finale4_b1.wav"
    } else if ("finale2") {
        local sounda = "music/sp_a4_finale4_b2.wav"
    } else if ("finale3") {
        local sounda = "music/sp_a4_finale4_b3.wav"
    } else if ("finale4") {
        local sounda = "music/sp_a4_finale4_b4.wav"
    } else if ("finale5") {
        local sounda = "music/sp_a4_finale4_b5.wav"
    } else if ("finale6") {
        local sounda = "music/sp_a4_finale4_b6.wav"
    } else if ("finale7") {
        local sounda = "music/sp_a4_finale4_b7.wav"
    } else if ("finale8") {
        local sounda = "music/sp_a4_finale4_b8.wav"
    } else if ("finale9") {
        local sounda = "music/sp_a4_finale4_b9.wav"
    } else if ("finale10") {
        local sounda = "music/sp_a4_finale4_b10.wav"
    } else if (typeof sound == "string") {
        local sounda = sound
    } else {
        print("Must be a string!")
    }
    Precache(sounda)
    Entities.FindByName(null,"@glados").EmitSound(sounda)
}


//blue.EmitSound("vo/glados/chellgladoswakeup06.wav")
//Entities.FindByName(null,"@glados").EmitSound("music/sp_a2_bts1_x1.wav")




//blue.SetOrigin(Vector(257.885, 786.005, 80.794))
//blue.SetAngles(2.102584, 90.752625, 0.000000)
//LETS SOLVE EVERY SINGLE CHAMBER IN THE GAME
/*
if (GetMapName() == "mp_coop_paint_walljumps") {
    blue.SetOrigin(Vector(223.388,1425,384.031))
    red.SetOrigin(Vector(806.286,1425.906,384.031))
}
if (GetMapName() == "mp_coop_paint_speed_fling") {
    blue.SetOrigin(Vector(1134.265503,445.280853,-383.968750))
    red.SetOrigin(Vector(1127.979736,-134.143707,-383.968750))
}
if (GetMapName() == "mp_coop_paint_red_racer") {
    blue.SetOrigin(Vector(-1543.413330,2164.613525,187.917786))
    red.SetOrigin(Vector(-950.725769,2152.062500,192.031250))
}
if (GetMapName() == "mp_coop_paint_speed_catch") {
    red.SetOrigin(Vector(1653.475952,-299.292450,0.031250))
    blue.SetOrigin(Vector(1647.910034, 302.041748, 0.031250))
}
if (GetMapName() == "mp_coop_paint_longjump_intro") {
    red.SetOrigin(Vector(148.949326, 756.747620, 68.031250))
    blue.SetOrigin(Vector(-174.649307, 622.942139, 97.665825))
}
if (GetMapName()=="mp_coop_separation_1") {
    blue.SetOrigin(Vector(2208.750488, -4589.277344, -71.968750))
    red.SetOrigin(Vector(2293.753418, -4680.160645, -71.968750))
}
if (GetMapName() == "mp_coop_tripleaxis") {
    blue.SetOrigin(Vector(3275.199463, 2234.903076, 512.031250))
    red.SetOrigin(Vector(3461.128174, 2333.358887, 512.031250))
}
if (GetMapName() == "mp_coop_catapult_catch") {
    blue.SetOrigin(Vector(564.902710, 1725.175537, -67.968750))
    red.SetOrigin(Vector(445.571442,1871.317871, -67.968750))
}
if (GetMapName() == "mp_coop_start") {
    blue.SetOrigin(Vector(-9845.440430, 4353.059570, 130.682251))
    red.SetOrigin(Vector(-9720.997070, 4210.083496, 130.682251))
}
if (GetMapName() == "mp_coop_teambts") {
    EntFire("disk_loaded_relay","trigger")
}
*/