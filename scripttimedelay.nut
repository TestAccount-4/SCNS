TimeDelay <- function(time = 10,sound = null,endcmd = "",sound2 = null,dominutes = true,topleft = false,sound3 = null,ismapspawnthing = false) {
    ::scns_timedelaycur <- time
        IncludeScript("SRC/aperturekit")
        if (sound == null) 
        {} else {
            Precache(sound)
            Entities.FindByName(null,"@glados").EmitSound(sound)
        }
        ppmod.interval(function():(sound,endcmd,sound2,dominutes,topleft,sound3,ismapspawnthing) {
            IncludeScript("ppmod3.nut");
            ::scns_timedelaycur <- scns_timedelaycur -= 1
            if (dominutes == true) {
                local minutes = scns_timedelaycur / 60;
                local remaining_seconds = scns_timedelaycur % 60;
                if (remaining_seconds < 10) {
                    scns_txt <- ppmod.text(minutes + ":" + "0" + remaining_seconds);
                } else {
                    scns_txt <- ppmod.text(minutes + ":" + remaining_seconds);
                }
            } else {
                scns_txt <- ppmod.text(scns_timedelaycur.tostring());
            }
            if (scns_timedelaycur < 4) {
                if (sound2 == null) {
                } else {
                    Precache(sound2)
                    Entities.FindByName(null,"@glados").EmitSound(sound2)
                }
                scns_txt.SetColor("255 0 0", "0 0 0");
            } else if (scns_timedelaycur >= 4 && scns_timedelaycur <= 30) {
                scns_txt.SetColor("255 255 0", "0 0 0");
            } else {
                scns_txt.SetColor("0 255 255", "0 0 0");
            }
            if (topleft == true) {
                scns_txt.SetPosition(-28,0)
            }
            if (scns_timedelaycur < 30 && ismapspawnthing == true) {
                Precache(sound3)
                Entities.FindByName(null,"@glados").EmitSound(sound3)
            }
            scns_txt.Display(1);
            if (scns_timedelaycur == 0|| scns_timedelaycur < 0) {
                    SendToConsole(endcmd)
                    EntFire("scns_timedelayscript","kill")
                }
        },1,"scns_timedelayscript") 
    
}
FinalTimeDelay <- function(time = 10,sound = null,endcmd = "",sound2 = null,dominutes = true,topleft = false,sound3 = null,ismapspawnthing = false) {
    ::scns_timedelaycur <- time
    firstthing <- true
    local trigger1 = ppmod.trigger(Vector(946,-1456,960), Vector(128,64,64), "trigger_once");
    ppmod.keyval(trigger1,"spawnflags","4097");
    ppmod.fire(trigger1,"Enable");
    ppmod.addscript(trigger1,"OnStartTouch",function(activator,caller) {
      ppmod.fire("airlock_1-relay_blue_in","trigger")
      ppmod.fire("airlock_1-relay_orange_in","trigger")
    },0.0,-1,true);
        IncludeScript("SRC/aperturekit")
        if (sound == null) 
        {} else {
            Precache(sound)
            Entities.FindByName(null,"@glados").EmitSound(sound)
        }
        ppmod.interval(function():(sound,endcmd,sound2,dominutes,topleft,sound3,ismapspawnthing) {
            IncludeScript("ppmod3.nut");
            ::scns_timedelaycur <- scns_timedelaycur -= 1
            if (dominutes == true) {
                local minutes = scns_timedelaycur / 60;
                local remaining_seconds = scns_timedelaycur % 60;
                if (remaining_seconds < 10) {
                    scns_txt <- ppmod.text(minutes + ":" + "0" + remaining_seconds);
                } else {
                    scns_txt <- ppmod.text(minutes + ":" + remaining_seconds);
                }
            } else {
                scns_txt <- ppmod.text(scns_timedelaycur.tostring());
            }
            if (scns_timedelaycur < 4) {
                if (sound2 == null) {
                } else {
                    Precache(sound2)
                    Entities.FindByName(null,"@glados").EmitSound(sound2)
                }
                scns_txt.SetColor("255 0 0", "0 0 0");
            } else if (scns_timedelaycur >= 4 && scns_timedelaycur <= 30) {
                scns_txt.SetColor("255 165 0", "0 0 0");
            } else {
                scns_txt.SetColor("255 255 0", "0 0 0");
            }
            if (topleft == true) {
                scns_txt.SetPosition(-28,0)
            }
            if (scns_timedelaycur < 30 && ismapspawnthing == true && firstthing == true) {
                Precache(sound3)
                Entities.FindByName(null,"@glados").EmitSound(sound3)
                firstthing <- false
            }
            scns_txt.Display(1);
            if (scns_timedelaycur == 0|| scns_timedelaycur < 0) {
                    SendToConsole(endcmd)
                    EntFire("scns_timedelayscript","kill")
                }
        },1,"scns_timedelayscript") 
    
}
//script TimeDelay(120,"music/sp_a4_finale4_b1.wav","restart_level","labs/potato_timer_01.wav",true,true)