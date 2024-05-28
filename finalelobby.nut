if (GetMapName() == "mp_coop_lobby_3") {
    IncludeScript("SRC/aperturekit")
    EntFire("case_screen_flip", "Kill")
    EntFire("counter_screen_flip" "Kill")
    EntFire("movie_large", "SetMovie" "media/bluescreen.bik")
    EntFire("movie_large", "Enable")
    EntFire("track5-light_off", "disable")
    EntFire("track5-light_off", "kill")
    EntFire("track5-light_on", "enable")
    EntFire("track5-light_on", "kill")
    local shake = Entities.CreateByClassname("env_shake")
    ppmod.addoutput(shake,"amplitude",16)
    ppmod.addoutput(shake,"duration",2)
    ppmod.addoutput(shake,"frequency",80)
    ppmod.addoutput(shake,"spawnflags",4)
    ppmod.addoutput(shake,"radius",32767)
    ppmod.addoutput(shake,"targetname",UniqueString("shake"))
    ppmod.fire(shake,"StartShake")
    local sound = Entities.CreateByClassname("ambient_generic")
    Precache("vo/announcer/openingsafeguards01.wav")
    Precache("props/explosions/a4_semi_distant_explosion_01.wav")
    Precache("props/explosions/a4_semi_distant_explosion_02.wav")
    FindByEntIndex(1).EmitSound("vo/announcer/openingsafeguards01.wav")
    ppmod.interval(function():(shake) {
        ppmod.fire(shake,"StartShake")
        local random = RandomInt(1, 2)
        if (random == 1) {
            FindByEntIndex(1).EmitSound("props/explosions/a4_semi_distant_explosion_01.wav")
        } else {
            FindByEntIndex(1).EmitSound("props/explosions/a4_semi_distant_explosion_02.wav")
        }
    },15)
    ppmod.wait(function(){
        Precache("vo/announcer/openingsafeguards01.wav")
        FindByEntIndex(1).EmitSound("vo/announcer/openingsafeguards01.wav")
    },5.1)
} else {
   printl("not in lobby!");
}