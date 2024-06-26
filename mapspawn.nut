//********************************************************************************************
// MAPSPAWN.NUT (ALPHA) Version 0.1
//********************************************************************************************
//
//// Latest Patch Notes:
//
// Added Patch Notes.
// Added Test Commands, this is used so I can reliably get Vscript templates instead of having to look then up on vdc community every time I forget.
// Added Plans.
// Added GiveLaserEyes() function (bluelasereyes.nut is now obsolete, do not use.)
// Added ReturnParm() function, returns what you put into it. This function can be useful when you need to have a second modifier. Ex: ReturnParm(Entities.FindByClassname(null, "env_portal_laser").Destroy())
// Improved GetPicker() function.
// Finished Early Colored Partners Demo.
// Added IdleText.
// Added forgivingpaint boolean which makes gel more forgiving when set to true.
// Patched bug within the Connected Portals modification so it doesn't break when a player dies.
// Fixed SwapTeams Script, can now be run more than once for map transition.
// Fixed KillPlayer() function.
// Added more developer modifications.
// Readded p2mm. Additions: {
//   Added 'restart' to !vote command for p2mm.
//   Added 'p2mm' command, makes server say what is typed after '!p2mm'
//   Added 'playerstrip' command, strips the portalgun from the player specified, supports @a,@o,@b and @s.
//   Added 24 new tracks to listen to in the lobby.
//   Improved 'changeteam' command, now supports changing teams of other players and supports team -1 (doesn't work for other players.)
//   if p2mm_developer is set to '18', p2mm will be disabled. 
// }
// Added WIP project for a multiplayer mod server which adds an extra assembly chamber. Support for all assemblers, even ones made with instances. (DOESN'T WORK YET!!)
// Some other minor bug fixes.
//
//// Test Commands:
//
// EntFire("!picker","addoutput","OnPressed !activator:ignitelifetime:99999999:0:-1")
// EntFire("!picker","addoutput","OnPressed !activator:ignitelifetime:0:0:-1")
// EntFireByHandle("@clientcommand","command","alias +forward say forward",0.0,FindByEntIndex(2),FindByEntIndex(2))
// EntFireByHandle(ent, input, param, delay, activator, caller)
// cvar_set ui_pvplobby_friends_invitetime -1
// cvar_set sv_portal_coop_ping_cooldown_time -1 
// cvar_set ui_transition_time 0
//
//// Plans:
// NOTE: Priorities go from 1 (might be done, but other things must be completed first.) to 5 (will definitely be fixed, hopefully as soon as possible.)
/// Priority 5:
// None.
/// Priority 4:
// Finish extra assembler modification. (Priority 4)
/// Priority 3:
// Work on Colored Partners mod. (Priority 3)
// Finish work on Advanced Cooperative Testing Initiative Demo. (Priority 3)
// Fixing replacetriggerhurt.nut (Priority 3)
// Fixing movecatapult scripts. (Priority 3)
// Remove placeportalanywhere.nut, organizing. (priority 3)
// Remove failed spawning attempt scripts, organizing. (Priority 3)
// Improve bluelasereyes. (Priority 3)
// Improve disabletarget.cfg, not listed in SCNS. (Priority 3)
// Priority: 2
// Add more mapspawn functions. (Priority 2)
// Move all setup scripts to a library, organizing. (Priority 2)
// Move all arbitrary scripts like makecubebouncy.nut and makecubespeedy.nut to mapspawn.nut or library, organizing. (Priority 2)
// Fix 'LOOKATRED.nut' (Priority 2)
// Priority: 1
// Modify keypad map selection script: {
//   Define Variable by default, not requiring use of kp_reset.
//   Add Text-based Gui for keypad, not requiring use for console to see map names.
//   Fix issues with keypad scripts not executing scripts properly.
// } (Priority 1)
//// End of comments.

if (GetDeveloperLevel() == 101) {
  return;
}
if (!("Entities" in this)) return;
print("==== calling mapspawn.nut")

IncludeScript("ppmod4.nut")
IncludeScript("src/pcapture-lib")
IncludeScript("scripttimedelay.nut")
IncludeScript("atlasradio.nut")
EntFire("worldspawn","addoutput","paintinmap 1")
NoclipState <- false
ReturnParm <- function(parma) {
  return parma
}
GiveLaserEyes <- function(Index = 1, Remove = false) {
    if (typeof FindByEntIndex(Index) != "instance" && Index != "all" && Index != "@a") {
        return print("Error: Index must be a valid entindex() of a player or must be \"all\" or \"@a\"")
    }
    if (Remove == false) {
        if (Index == "all" || Index == "@a") {
            for (local player; player = Entities.FindByClassname(player, "player");) {
                local laser1 = Entities.CreateByClassname("env_portal_laser")
                local host = player

                laser1.SetOrigin(host.EyePosition())
                print(laser1.GetOrigin())
                print(host.GetOrigin())
                ppmod.fire(laser1,"turnon")
                laser1.__KeyValueFromString("targetname","scns_laser" + player.entindex() + "_")
                local laser1_interval = ppmod.interval(function():(laser1,host,player) {
                    local traceResult = TracePlus.FromEyes.Cheap(17,player)
                    laser1.SetOrigin(traceResult.GetHitpos())
                    local DirectionAngles = entLib.FromEntity(player).EyeAngles()
                    laser1.SetAngles(DirectionAngles.x,DirectionAngles.y,DirectionAngles.z)
                },0.01,"scns_laser" + player.entindex() + "_interval_")
                return
            }
        }
        local host = FindByEntIndex(Index)
        local laser1 = Entities.CreateByClassname("env_portal_laser")
        local newblueori = host.GetOrigin()

        laser1.SetOrigin(host.EyePosition())
        print(laser1.GetOrigin())
        print(host.GetOrigin())
        ppmod.fire(laser1,"turnon")
        laser1.__KeyValueFromString("targetname","scns_laser" + host.entindex() + "_")
        ppmod.interval(function():(laser1,host,Index) {
            local traceResult = TracePlus.FromEyes.Cheap(24,FindByEntIndex(Index))
            laser1.SetOrigin(traceResult.GetHitpos())
            local DirectionAngles = entLib.FromEntity(FindByEntIndex(Index)).EyeAngles()
            laser1.SetAngles(DirectionAngles.x,DirectionAngles.y,DirectionAngles.z)
        },0.01,"scns_laser" + host.entindex() + "_interval_")
        local laser1_interval = Entities.FindByName(null, "scns_laser" + host.entindex() + "_interval_")
        local result = {}
        result[1] = laser1
        result[2] = laser1_interval
        return result
    } else if (Remove == true) {
        if (Index == "all" || Index == "@a") {
            for (local player; player = Entities.FindByClassname(player, "player");) {
                local laser1 = Entities.FindByName(null,"scns_laser" + player.entindex() + "_")
                local host = player
                local laser1_interval = Entities.FindByName(null,"scns_laser" + player.entindex() + "_interval_")
                laser1.Destroy()
                laser1_interval.Destroy()
                return
            }
        }
        local host = FindByEntIndex(Index)
        local laser1 = Entities.FindByName(null,"scns_laser" + host.entindex() + "_")
        local newblueori = host.GetOrigin()
        local laser1_interval = Entities.FindByName(null"scns_laser" + host.entindex() + "_interval_")
        laser1.Destroy()
        laser1_interval.Destroy()
        return
    } else {
        return print("Error: \"Remove\" parameter must be a boolean between True or False.")
    }
    
}
MPTP <- function(index1,index2) {
  FindByEntIndex(index1).SetOrigin(FindByEntIndex(index2).GetOrigin())
}
PlacePortal <- function(group = 1,portal = 1,pos= "0 0 0",ang = "0 0 0") {
  local p1 = ppmod.get("prop_portal")
  local p2 = ppmod.get("prop_portal",p1)
  local p3 = ppmod.get("prop_portal",p2)
  local p4 = ppmod.get("prop_portal",p3)
  if (typeof pos == "Vector") {
    pos2 <- pos.x + " " + pos.y + " " + pos.z
  } else if (typeof pos == "string") {
    pos2 <- pos
  } else {
    print("WARNING: Portal Position ust be a Vector or String!")
  }
  if (typeof ang == "Vector") {
    ang2 <- ang.x + " " + ang.y + " " + ang.z
  } else if (typeof ang == "string") {
    ang2 <- ang
  } else {
    print("WARNING: Portal Angles must be a Vector or String!")
  }
  if (group == 1) {
    if (portal == 1) {
      ppmod.fire(p1,"newlocation",pos2+" "+ang2)
      ppmod.fire(p1,"SetActivatedState","1")
      return p1
    } else {
      ppmod.fire(p2,"newlocation",pos2+" "+ang2)
      ppmod.fire(p2,"SetActivatedState","1")
      return p2
    }
  } else if (group == 2) {
    if (portal == 1) {
      ppmod.fire(p3,"newlocation",pos2+" "+ang2)
      ppmod.fire(p3,"SetActivatedState","1")
      return p3
    } else {
      ppmod.fire(p4,"newlocation",pos2+" "+ang2)
      ppmod.fire(p4,"SetActivatedState","1")
      return p4
    }
  } else {
    print("Must be a valid group number!")
  }
}
SetPlayerModel <- function(Player = 1,Model = null) {
  if (Player == 1) {
    local ent = null;     
    while(ent = Entities.FindByName(ent, "blue"))
    {
    ent.SetModel(MODEL1)
    }
  } else {
    if (Player == 2) {
      local ent = null;    
      while(ent = Entities.FindByName(ent, "red"))
      {
      ent.SetModel(MODEL1)
      }
    } else {
      if (Player == 3) {
        local ent = null;     
        while(ent = Entities.FindByClassname(ent, "*"))
        {
          ent.SetModel(MODEL1)
          print("should have done it.")
        }
        
      } else {
        print("Defined local instance of Player not specified within the specified range, please select either 1 or 2 for this instance.")
      }
    }
  }
}
GetPicker <- function(PlayerIndex = 1,ignoreinvis = true,DebugMode = false) {
  // EntFire("!picker","runscriptcode","::scns_picker <- self")
  // return scns_picker
  /// ^^^ OLD METHOD!!!
  // print(PlayerIndex)
  if (ignoreinvis == true) {
    local traceSettings = TracePlus.Settings.new({
        ignoreClasses = arrayLib.new("worldspawn","func_brush","func_detail","info_target","trigger_catapult","trigger_playerteam","trigger_once","trigger_multiple","trigger_hurt","logic_auto","logic_relay","light","env_cubemap","trigger_portal_cleanser","trigger_push","trigger_teleport","env_fade","ambient_generic","logic_branch","env_texturetoggle","env_instructor_hint","env_sprite","func_instance_io_proxy","light_spot","info_overlay","math_counter","env_soundscape","logic_coop_manager","physicsclonearea"),
        errorTolerance = 100
    })
    local traceResult = TracePlus.FromEyes.Bbox(1024, FindByEntIndex(PlayerIndex), null, traceSettings)
    if (traceResult.DidHit()) {
      local traceent = traceResult.GetEntity()
      if (DebugMode == true) {
        print(FindByEntIndex(traceent.GetIndex()))
        print(traceResult.GetEntityClassname())
      }
      if (traceResult.DidHitWorld() == false) {
        return FindByEntIndex(traceent.GetIndex())
      } else if (DebugMode == true) {
        print("hit world.")
      }
    } else if (DebugMode == true) {
        print("didn't hit anything.")
    }
  } else if (ignoreinvis == false) {
    local traceSettings = TracePlus.Settings.new({
        ignoreClasses = arrayLib.new("worldspawn","func_brush","func_detail","info_target"),
        errorTolerance = 100
    })
    local traceResult = TracePlus.FromEyes.Bbox(1024, FindByEntIndex(PlayerIndex), null, traceSettings)
    if (traceResult.DidHit()) {
      local traceent = traceResult.GetEntity()
      if (DebugMode == true) {
        print(FindByEntIndex(traceent.GetIndex()))
        print(traceResult.GetEntityClassname())
      }
      if (traceResult.DidHitWorld() == false) {
        return FindByEntIndex(traceent.GetIndex())
      } else if (DebugMode == true) {
        print("hit world.")
      }
    } else if (DebugMode == true) {
        print("didn't hit anything.")
    }
  } else if (DebugMode == true) {
    print("ignoreinvis parameter is invalid")
  }
}
// B9TC <- function(base9Str) {
//     // Convert a base 9 string to an integer
//     local base9Value = 0;
//     local length = base9Str.len();
//     for (local i = 0; i < length; i++) {
//         base9Value = base9Value * 9 + (base9Str[i].tointeger() - 1);
//     }
//     return chr(base9Value);
// }
// CNSTS <- function(numStrO){
//     local result = "";
//     local numStr = ppstring(numStrO)
//     local chunks = numStr.split("0"); // Split the string by '0'
  
//     foreach (chunk in chunks) {
//         if (chunk != "") { // Ignore empty chunks resulting from consecutive '0's
//             local char = B9TC(chunk);
//             result += char;
//         }
//     }
  
//     return result;
// }
// function CSTNS(inputStr) {
//   // Converts String to a Number-style conversion method that i use to execute scripts
//   // 0 is the divider so base 1-9 as numbers can be converted into a string using sar_function so i dont have to manually type everything with script command
//   // I just want to use sar_function lol, that's why i made this
//     local result = "";
  
//     for (local i = 0; i < inputStr.len(); i++) {
//         local char = inputStr[i];
//         local base9Str = B9TC(char);
//         result += base9Str + "0"; // Add '0' as the divider
//     }
  
//     // Remove the trailing '0'
//     if (result.len() > 0) {
//         result = result.slice(0, -1);
//     }
  
//     return result;
// }
// // local numberString = "12024024021"; // Example input representing "cool"
//
// These scripts are broken.

FindObject <- function(ent) {
local hint = entLib.CreateByClassname("env_instructor_hint", {
  hint_allow_nodraw_target = 1,
  hint_alphaoption = 0,
  hint_binding = "say",
  hint_color = "255 255 255",
  hint_forcecaption = 0,
  hint_caption = " "
  hint_icon_offscreen = "icon_arrow_plain",
  hint_icon_offset = 0,
  hint_icon_onscreen = "icon_tip",
  hint_timeout = 0,
  hint_pulseoption = 0,
  hint_shakeoption = 0,
  hint_static = 0,
  hint_range = 0,
  hint_local_player_only = 0,
  hint_target = ent,
  targetname = UniqueString("scns_chathint")
})
ppmodhint <- ppmod.get(hint.GetName())
ppmod.fire(ppmodhint,"ShowHint")
}
changeteam <- function(p,args) {
  try {
      if (args == "0" || args == "2" || args == "3" || args == "-1") {
          if (p.GetTeam() == args.tointeger()) {
              return SendChatMessage("[ERROR] Already on this team!", p)
          } else if (args == "-1") { 
              p.SetTeam(0)
              ppmod.fire(p,"addoutput","teamnumber -1")
              return SendChatMessage("[ERROR] Team is now set to TEAM_BETA.", p)
          } else {
              p.SetTeam(args.tointeger())
              return SendChatMessage("Team is now set to " + teams[args.tointeger()] + ".", p)
          }
      }
      // No argument, so just cycle through the teams
      if (args.len() == 0|| args == "") {
          local iNewTeam = null
          switch (p.GetTeam()) {
              case 0: iNewTeam = 2;    break;
              case 2:          iNewTeam = 3;   break;
              case 3: iNewTeam = 0;   break;
              case -1: iNewTeam = 3
          }
          p.SetTeam(iNewTeam)
          SendChatMessage("Toggled to " + teams[iNewTeam] + " team.", p)
      } else {
        SendChatMessage("[ERROR] Enter a valid team number: 0, 2, or 3!", p)
      }
  } catch (exception) {
      // No argument, so just cycle through the teams
      if (args.len() == 0|| args == "") {
          local iNewTeam = null
          switch (p.GetTeam()) {
              case TEAM_SINGLEPLAYER: iNewTeam = TEAM_RED;    break;
              case TEAM_RED:          iNewTeam = TEAM_BLUE;   break;
              case TEAM_BLUE: iNewTeam = TEAM_SINGLEPLAYER;   break;
              case -1: iNewTeam = TEAM_BLUE
          }
          p.SetTeam(iNewTeam)
          SendChatMessage("Toggled to " + teams[iNewTeam] + " team.", p)
      }
  } 
}
PlayerStrip <- function(Player = 1) {
  if (typeof Player == "integer") {
    local portalgun = FindByIntHandle("weapon_portalgun",Player)
    ppmod.fire(portalgun,"addoutput","canfireportal1 0")
    ppmod.fire(portalgun,"addoutput","canfireportal2 0")
  } else if (typeof Player == "instance") {
    local portalgun = FindByIntHandle("weapon_portalgun",Player.entindex())
    ppmod.fire(portalgun,"addoutput","canfireportal1 0")
    ppmod.fire(portalgun,"addoutput","canfireportal2 0")
  } else if (typeof Player == "string") {
    local portalgun = FindByIntHandle("weapon_portalgun",FindPlayerByName(Player).entindex())
    ppmod.fire(portalgun,"addoutput","canfireportal1 0")
    ppmod.fire(portalgun,"addoutput","canfireportal2 0")
    SendChatMessage(portalgun)
  }
}
SetLobbyMovie <- function(moviename) {
if (GetMapName() == "mp_coop_lobby_3"||GetMapName() == "mp_coop_lobby_2") {
  EntFire("case_screen_flip", "Kill")
  EntFire("counter_screen_flip", "Kill")
  EntFire("movie_large" ,"SetMovie", moviename)
  EntFire("movie_large", "Enable")
}
print("[SCNS]: Please note that this script will only work once.")
}
FindByEntIndex <- function(ent_index = "null") {
if (ent_index == "null") {
  dev.warning("Index not specified!")
} else {
  local ent = Entities.First()
  while (ent != null) // Continue until there are no more entities
  {
    if (ent.entindex() != ent_index) {
      ent = Entities.Next(ent); // Proceed to the next entity
    } else {
      return ent
    }
  }    
}
}
FindByIntHandle <- function(className, IntHandle) {
    local ent = null;
    local count = 1;
    if (className == "null" || IntHandle == "null") {
      return printl("KeyValue not specified!")
    }

    local entity = Entities.First();
    while (entity != null) {
        if (entity.GetClassname() == className) {
            if (count == IntHandle) {
                ent = entity;
                break;
            }
            count++;
        }
        entity = Entities.Next(entity); 
    }
    return ent;
}
FindByKeyValue <- function(key = "null",val = "null") {
Print("Experimental!")
dev.warning("Broken!")
if (key == "null" || val = "null") {
  dev.warning("KeyValue not specified!")
} else {
  local ent = Entities.First()
  while (ent != null) // Continue until there are no more entities
  {
    if (ent.GetKeyString(key) != val||ent.GetKeyString(key) != val.tointeger()||ent.GetKeyString(key) != val.tostring()) {
      ent = Entities.Next(ent); // Proceed to the next entity
    } else {
      return ent
    }
  }    
}
}
SetPlayerTeam <- function(PlayerIndex = "null",Team = 3) {
if (PlayerIndex == "null") {
  dev.warning("Index not specified!")
} else {
  local PlayerInstance = FindByEntIndex(PlayerIndex)
  PlayerInstance.SetTeam(Team)   
}
}
KillPlayer <- function(PlayerIndex = "all") {
  if (PlayerIndex == "both") {
    ppmod.fire(FindByEntIndex(1),"sethealth",-100);
    ppmod.fire(FindByEntIndex(2),"sethealth",-100);
  } else if (PlayerIndex == "red") {
    ppmod.fire(FindByEntIndex(2),"sethealth",-100);
  } else if (PlayerIndex == "blue") {
    ppmod.fire(FindByEntIndex(1),"sethealth",-100);
  } else if (PlayerIndex == "orange") {
    ppmod.fire(FindByEntIndex(2),"sethealth",-100);
  } else if (PlayerIndex == "all") {
    for (local player; player = Entities.FindByClassname(player, "player");) {
      ppmod.fire(player,"sethealth",-100)
    }
  } else {
    local PlayerInstance = FindByEntIndex(PlayerIndex)
    ppmod.fire(PlayerInstance,"sethealth",-100);
    
  }
}
SwapPlayerThing <- function(extraplayers = 0) {
  if (typeof extraplayers != "integer") {
    dev.warning("Must be an integer!")
    return;
  }
  local host = FindByEntIndex(1)
  local partner = FindByEntIndex(2)
  local hostpos = host.GetOrigin()
  local partnerpos = partner.GetOrigin()
  host.SetOrigin(partnerpos)
  partner.SetOrigin(hostpos)
  host.SetAngles(partner.GetAngles())
  partner.SetAngles(host.GetAngles())
  // local bluep1 = ppmod.get("prop_portal")
  // local bluep2 = ppmod.get("prop_portal",bluep1)
  // bluep1.SetOrigin(bluep2.GetOrigin())
  // bluep2.SetOrigin(bluep1.GetOrigin())
}
idletext <- false
forgivingpaint <- false
scns_ignorevariable1 <- false //Ignore.

 ppmod.onauto(async(function () {
  ppmod.interval(function() {
  IncludeScript("ppmod3.nut");
  if (idletext == true) {
    scns_txt <- ppmod.text("Server is idle.");
    scns_txt.SetPosition(0.005,0.925)
    scns_txt.SetColor("0 255 0", "0 0 0");
    scns_txt.Display(1);
    ppmod.keyval(scns_txt.GetEntity,"channel","8")
  }
  if (forgivingpaint == true && scns_ignorevariable1 == false) {
      ppmod.getall(["info_paint_sprayer"],function(ent_a) {
        ppmod.fire(ent_a,"addoutput","blob_spread_radius 32")
        ppmod.fire(ent_a,"addoutput","blob_streak_percentage 100")
        ppmod.fire(ent_a,"addoutput","min_streak_speed_dampen 50")
        ppmod.fire(ent_a,"addoutput","max_streak_speed_dampen 150")
        ppmod.fire(ent_a,"addoutput","min_streak_time 8")
        ppmod.fire(ent_a,"addoutput","max_streak_time 8")    
      })
      scns_ignorevariable1 <- true
    }
  },1,"scns_maininterval") 
  ::pgun1 <- ppmod.get("weapon_portalgun")
  ::pgun2 <- ppmod.get("weapon_portalgun",pgun1)
  EntFire("worldspawn","addoutput","paintinmap 1")
  //EntFire("@command","command","exec auto")
  //EntFire("@command","command","script_execute scripttimedelay.nut")
  ::blue <- ppmod.get("blue")
  ::red <- ppmod.get("red")
  ::host <- FindByEntIndex(1)
  ::partner <- FindByEntIndex(2)
  ::omnipartner <- FindByEntIndex(3)
  ::spawncube <- function(pos = blue.GetOrigin()) {
    local cube = ppmod.create("prop_weighted_cube").then(function (cube) {
      cube.SetOrigin(pos);
    });
    return cube;
  }
if (GetDeveloperLevel() == 3) {
    // ppmod.player
    ppmod.interval(function ():(red) {

    local feetpos = red.GetOrigin() - Vector(0, 0, 18);
    local cube = ppmod.get(feetpos, 8, "prop_weighted_cube");

    if (!cube) {
      if (cube.GetKeyString("color") == "0 255 0") {

      }
    }

  }, 0.5);
  ppmod.interval(function ():(blue) {

    local feetpos = blue.GetOrigin() - Vector(0, 0, 18);
    local cube = ppmod.get(feetpos, 8, "prop_weighted_cube");

    if (!cube) {
      if (cube.GetKeyString("color") == "0 255 0") {
          p
      }
    }
  }, 0.5);
} else if (GetDeveloperLevel() == 4) {
  Entities.FindByName(null,"red").SetTeam(3);
  Entities.FindByName(null,"blue").SetTeam(2);
  ppmod.interval(function() {
    local p1 = ppmod.get("prop_portal")
    local p2 = ppmod.get("prop_portal",p1)
    local p3 = ppmod.get("prop_portal",p2)
    local p4 = ppmod.get("prop_portal",p3)
    if (p1 != null||p1) {
      if (GetKeyString(p1,"LinkageGroupID" == 999)) {
       ppmod.fire(p1, "SetLinkageGroupID", 2)
      }
    }
  },2)
} else if (GetDeveloperLevel() == 5||GetDeveloperLevel() == 5.1||GetDeveloperLevel() == 5.2||GetDeveloperLevel() == 5.3||GetDeveloperLevel() == 5.4||GetDeveloperLevel() == 5.5||GetDeveloperLevel() == 5.6) {
  ppmod.fire(red,"color","0 255 0")
  ppmod.fire(blue,"color","255 0 0")
  // Setup for blue color
  ppmodeye <- function(playername) {
            // Set up a logic_measure_movement for more accurate view angles
      pplayereyes <- Entities.CreateByClassname("logic_measure_movement");
      local eyename = UniqueString("ppmod_eyes");

      ppmod.keyval(pplayereyes,"MeasureType", 1);
      ppmod.keyval(pplayereyes,"Targetname", eyename);
      ppmod.keyval(pplayereyes,"TargetReference", eyename);
      ppmod.keyval(pplayereyes,"Target", eyename);
      pplayereyes.SetAngles(0, 0, 90.0);

      EntFireByHandle(pplayereyes, "SetMeasureReference", eyename, 0.0, null, null);
      EntFireByHandle(pplayereyes, "Enable", "", 0.0, null, null);

      // logic_measure_movement relies on targetname for selecting entities
      // This changes the player's targetname briefly and set it back right away
        
        ppmod.get(playername).__KeyValueFromString("Targetname", UniqueString("pplayer"));
        
        EntFireByHandle(pplayereyes, "SetMeasureTarget", "blue", 0.0, null, null);

        ppmod.wait(function ():(playername) {
          ppmod.keyval(ppmod.get(playername),"Targetname", playername);
          pplayereyes.Destroy()
        }, FrameTime());


    return pplayereyes
  }
  if (GetMapName() == "mp_coop_doors") { // mp_coop_doors thing
    // local Instances
    local button1 = ppmod.get("prop_floor_button")
    local button2 = ppmod.get("prop_floor_button",button1)
    local button3 = ppmod.get("prop_floor_button",button2)
    local door1 = ppmod.get("prop_testchamber_door")
    local door2 = ppmod.get("prop_testchamber_door",door1)
    local door3 = ppmod.get("prop_testchamber_door",door2)
    // Entfire
    ppmod.fire(button3,"color","255 0 0")
    ppmod.fire(button2,"color","0 255 0")
    ppmod.fire("InstanceAuto7-red_dropper-cube_dropper_prop","color","0 255 0")
    ppmod.fire("InstanceAuto7-blue_dropper-cube_dropper_prop","color","255 0 0")
    ppmod.fire(door1,"color","255 0 0")
    ppmod.fire(door2,"color","0 255 0")
    ppmod.fire("blue-station","color","255 0 0")
    ppmod.fire("orange-station","color","0 255 0")
    // Outputs
    ppmod.addscript("rl_start_exit","OnTrigger",function() {
      EntFire("@command","command","developer 5.1")
    });
    ppmod.addscript(button2,"OnPressedBlue",function() {
        IncludeScript("ppmod4.nut");
        local button1 = ppmod.get("prop_floor_button");
        local button2 = ppmod.get("prop_floor_button",button1);
        local button3 = ppmod.get("prop_floor_button",button2);
        button2.Fire("PressOut")
    })
    ppmod.addscript(button3,"OnPressedOrange",function() {
        IncludeScript("ppmod4.nut");
        local button1 = ppmod.get("prop_floor_button");
        local button2 = ppmod.get("prop_floor_button",button1);
        local button3 = ppmod.get("prop_floor_button",button2);
        button3.Fire("PressOut")
    })
    // Create Trigger that damages non-specific colored player
    local trigger1 = ppmod.trigger(Vector(-9728, -528, 57.77), Vector(64, 16, 58), "trigger_multiple");
    ppmod.keyval(trigger1,"damagetype","0");
    ppmod.keyval(trigger1,"filtername","red");
    ppmod.keyval(trigger1,"spawnflags","4097");
    ppmod.fire(trigger1,"Enable");
    ppmod.addscript(trigger1,"OnStartTouch",function(activator,caller) {
      if (activator.GetName() == "red") {
        IncludeScript("ppmod4.nut");
        ppmod.fire(activator,"sethealth",0)
        ppmod.fire(activator,"sethealth",0)
        ppmod.fire(activator,"sethealth",0)
        ppmod.fire(activator,"sethealth",0)
        ppmod.fire(activator,"sethealth",0)
        ppmod.fire(activator,"sethealth",0)
        ppmod.fire(activator,"sethealth",0)
        ppmod.fire(activator,"sethealth",0)
        ppmod.fire(activator,"sethealth",0)
      }
    },0.0,-1,true);
    local trigger2 = ppmod.trigger(Vector(-10144, -528, 57.77), Vector(64, 16, 58), "trigger_multiple");
    ppmod.keyval(trigger2,"damagetype","0");
    ppmod.keyval(trigger2,"filtername","red");
    ppmod.keyval(trigger2,"spawnflags","4097");
    ppmod.fire(trigger1,"Enable");
    ppmod.addscript(trigger2,"OnStartTouch",function(activator,caller) {
      if (activator.GetName() == "blue") {
        IncludeScript("ppmod4.nut");
        ppmod.fire(activator,"sethealth",0)
        ppmod.fire(activator,"sethealth",0)
        ppmod.fire(activator,"sethealth",0)
        ppmod.fire(activator,"sethealth",0)
        ppmod.fire(activator,"sethealth",0)
        ppmod.fire(activator,"sethealth",0)
        ppmod.fire(activator,"sethealth",0)
        ppmod.fire(activator,"sethealth",0)
        ppmod.fire(activator,"sethealth",0)
      }
    },0.0,-1,true);
    // Final Text
    local txt = ppmod.text("Welcome to the Colored Partners Mod.");
    txt.SetColor("255 0 0", "255 255 255");
    txt.SetFade(0.1, 2, true);
    txt.Display(3); //display the text
  } else if (GetMapName() == "mp_coop_race_2") { // second map in course 01
    // Local Instances
    local button1 = ppmod.get("prop_button"); //top right button
    local button2 = ppmod.get("prop_button",button1); // bottom right button
    local button3 = ppmod.get("prop_button",button2); // first button that appears
    local button4 = ppmod.get("prop_button",button3); // bottom left button
    local button5 = ppmod.get("prop_button",button4); // top left button
    local door1 = ppmod.get("prop_testchamber_door");
  
    // Entfire
    ppmod.fire(button1,"color","255 0 0"); 
    ppmod.fire(button2,"color","0 255 0");
    ppmod.fire(button3,"color","0 255 0"); // first button
    ppmod.fire(button4,"color","255 0 0");
    ppmod.fire(button5,"color","0 255 0");
    ppmod.fire("cube_dropper_prop","color","0 0 255")
    ppmod.fire("entry_airlock-blue_dropper-cube_dropper_prop","color","255 0 0");
    ppmod.fire("entry_airlock-red_dropper-cube_dropper_prop","color","0 255 0");
    ppmod.fire("InstanceAuto8-red_dropper-cube_dropper_prop","color","0 255 0");
    ppmod.fire("InstanceAuto8-blue_dropper-cube_dropper_prop","color","255 0 0");
    ppmod.fire("blue-station","color","255 0 0");
    ppmod.fire("orange-station","color","0 255 0");
    ppmod.fire(door1,"color","0 0 255");
    ppmod.fire("button_ball-button","color","0 0 255");
  

    // Outputs
    ppmod.addscript(button1,"OnPressedOrange",function() {
      local button1 = ppmod.get("prop_button"); //top right button
      local button2 = ppmod.get("prop_button",button1); // bottom right button
      local button3 = ppmod.get("prop_button",button2); // first button that appears
      local button4 = ppmod.get("prop_button",button3); // bottom left button
      local button5 = ppmod.get("prop_button",button4); // top left button
      ppmod.fire(button1,"cancelpress")
      ppmod.fire("timer_2_branch","SetValue","0")
      ppmod.fire("timer_2","Reset",0)
    })
    ppmod.addscript(button2,"OnPressedBlue",function() {
      local button1 = ppmod.get("prop_button"); //top right button
      local button2 = ppmod.get("prop_button",button1); // bottom right button
      local button3 = ppmod.get("prop_button",button2); // first button that appears
      local button4 = ppmod.get("prop_button",button3); // bottom left button
      local button5 = ppmod.get("prop_button",button4); // top left button
      ppmod.fire(button2,"cancelpress")
      ppmod.fire("timer_1_branch","SetValue","0")
      ppmod.fire("timer_1","Reset",0)
    })
    ppmod.addscript(button3,"OnPressedBlue",function() { // First Button
    local button1 = ppmod.get("prop_button"); //top right button
      local button2 = ppmod.get("prop_button",button1); // bottom right button
      local button3 = ppmod.get("prop_button",button2); // first button that appears
      ppmod.fire(button3,"cancelpress")
      ppmod.fire("paneldoor-airlock_entry_door_close_rl","trigger")
      ppmod.fire("timer_training_light_toggle","SetTextureIndex",0)
      ppmod.fire("switch_door_2_indicator","reset")

    })
    ppmod.addscript(button4,"OnPressedOrange",function() {
      local button1 = ppmod.get("prop_button"); //top right button
      local button2 = ppmod.get("prop_button",button1); // bottom right button
      local button3 = ppmod.get("prop_button",button2); // first button that appears
      local button4 = ppmod.get("prop_button",button3); // bottom left button
      local button5 = ppmod.get("prop_button",button4); // top left button
      ppmod.fire(button4,"cancelpress")
      ppmod.fire("timer_4_branch","SetValue","0")
      ppmod.fire("timer_4","Reset",0)
    })
    ppmod.addscript(button5,"OnPressedBlue",function() {
      local button1 = ppmod.get("prop_button"); //top right button
      local button2 = ppmod.get("prop_button",button1); // bottom right button
      local button3 = ppmod.get("prop_button",button2); // first button that appears
      local button4 = ppmod.get("prop_button",button3); // bottom left button
      local button5 = ppmod.get("prop_button",button4); // top left button
      ppmod.fire(button5,"cancelpress")
      ppmod.fire("timer_3_branch","SetValue","0")
      ppmod.fire("timer_3","Reset",0)
      ppmod.fire("switch_door_2_indicator","reset")
    })

    // Blue color

    ppmod.interval(function() {
      ppmod.fire("prop_weighted_cube","color","0 0 255")
    },1.5)
    ::cubeStates <- {};
    local pingblue1 = Entities.CreateByClassname("info_player_ping_detector");
    ppmod.fire(pingblue1,"enable")
    ppmod.keyval(pingblue1,"TeamToLookAt","3")
    ppmod.addscript(pingblue1, "OnPingDetected",function() {
      print("pingdetected")
      ppmod.getall(["prop_weighted_cube"],function (cube) { /////////////////////////////////////////////1
      local blue = ppmod.get("blue");
      local red = ppmod.get("red");
      print("cubeishere!")
      local cubeIndex = cube.entindex();
      local traceSettings = TracePlus.Settings.new({
          priorityClasses = arrayLib.new("prop_weighted_cube"),
          errorTolerance = 100
      })
      local traceResult = TracePlus.FromEyes.Bbox(1024, FindByEntIndex(1), null, traceSettings)
      if (traceResult.DidHit()) {
        local traceent = traceResult.GetEntity()
        print(traceent.GetIndex())
          if (traceResult.DidHitWorld() == false && FindByEntIndex(traceent.GetIndex()) == cube) {
            print("looking at a cube!")
            local currentcubestate = macros.GetFromTable(cubeStates, cubeIndex, false)
            if (currentcubestate == false) {
              ppmod.fire(cube,"disablemotion");
              ppmod.fire(cube,"disablepickup");
              cubeStates[cubeIndex.tointeger()] <- true;
            } else if (currentcubestate == true) {
              ppmod.fire(cube,"enablemotion");
              ppmod.fire(cube,"enablepickup");
              cubeStates[cubeIndex.tointeger()] <- false;
            } 
          } else {
            print("hit world.")
            print(traceResult.GetEntityClassname())
            print(traceResult.GetEntity())
            print(cube)
          }
      } else {
          print("didn't hit anything.")
      }
      
    })//end of cube hook function
  })//end of entire script for info ping detector
    local pingred1 = Entities.CreateByClassname("info_player_ping_detector");
    ppmod.fire(pingred1,"enable")
    ppmod.keyval(pingred1,"TeamToLookAt","2")
    ppmod.addscript(pingred1, "OnPingDetected",function() {
      print("pingdetected")
      ppmod.getall(["prop_weighted_cube"],function (cube) { /////////////////////////////////////////////1
      local blue = ppmod.get("blue");
      local red = ppmod.get("red");
      print("cubeishere!")
      local cubeIndex = cube.entindex();
      local traceSettings = TracePlus.Settings.new({
          priorityClasses = arrayLib.new("prop_weighted_cube"),
          errorTolerance = 100
      })
      local traceResult = TracePlus.FromEyes.Bbox(1024, FindByEntIndex(2), null, traceSettings)
      if (traceResult.DidHit()) {
        local traceent = traceResult.GetEntity()
        print(traceent.GetIndex())
          if (traceResult.DidHitWorld() == false && FindByEntIndex(traceent.GetIndex()) == cube) {
            print("looking at a cube!")
            local currentcubestate = macros.GetFromTable(cubeStates, cubeIndex, false)
            if (currentcubestate == false) {
              ppmod.fire(cube,"disablemotion");
              ppmod.fire(cube,"disablepickup");
              cubeStates[cubeIndex.tointeger()] <- true;
            } else if (currentcubestate == true) {
              ppmod.fire(cube,"enablemotion");
              ppmod.fire(cube,"enablepickup");
              cubeStates[cubeIndex.tointeger()] <- false;
            } 
          } else {
            print("hit world.")
            print(traceResult.GetEntityClassname())
            print(traceResult.GetEntity())
            print(cube)
          }
      } else {
          print("didn't hit anything.")
      }
      
    })//end of cube hook function 2
  })//end of entire script for info ping detector 2
  } else if (GetMapName() == "mp_coop_laser_2") {
    // Setup EntFires

    EntFire("InstanceAuto27-red_dropper-cube_dropper_prop","color","0 255 0")
    EntFire("InstanceAuto27-blue_dropper-cube_dropper_prop","color","255 0 0")
    EntFire("button_arms-button","color","0 255 0")
    EntFire("blue-station","color","255 0 0")
    EntFire("orange-station","color","0 255 0")
    EntFire("reflectocube_dropper_prop","color","0 0 255")
    EntFire("npc_portal_turret_floor","color","255 0 0")
    EntFire("npc_portal_turret_floor","addoutput","UseSuperDamageScale 1")
    EntFire("prop_laser_catcher","color","0 0 255")
    EntFire("button_1","color","0 0 255")
    EntFire("prop_laser_relay","color","0 0 255")
    EntFire("@exit_door","color","0 0 255")
    EntFire("airlock_1-blue_dropper-cube_dropper_prop","color","255 0 0")
    EntFire("airlock_1-red_dropper-cube_dropper_prop","color","0 255 0")
    EntFire("coop_man_give_taunt","kill")

    // Setup Outputs

    ppmod.addscript("button_arms-button","OnPressed",function(activator,caller) {
      if (activator.GetName() != "red") {
        ppmod.fire("button_arms-button","pressout")
      }
    },0.0,-1,true)

    // Blue color

    ppmod.interval(function() {
      ppmod.fire("prop_weighted_cube","color","0 0 255")
    },1.5)
    ::cubeStates <- {};
    local pingblue1 = Entities.CreateByClassname("info_player_ping_detector");
    ppmod.fire(pingblue1,"enable")
    ppmod.keyval(pingblue1,"TeamToLookAt","3")
    ppmod.addscript(pingblue1, "OnPingDetected",function() {
      print("pingdetected")
      ppmod.getall(["prop_weighted_cube"],function (cube) { /////////////////////////////////////////////1
      local blue = ppmod.get("blue");
      local red = ppmod.get("red");
      print("cubeishere!")
      local cubeIndex = cube.entindex();
      local traceSettings = TracePlus.Settings.new({
          priorityClasses = arrayLib.new("prop_weighted_cube"),
          errorTolerance = 100
      })
      local traceResult = TracePlus.FromEyes.Bbox(1024, FindByEntIndex(1), null, traceSettings)
      if (traceResult.DidHit()) {
        local traceent = traceResult.GetEntity()
        print(traceent.GetIndex())
          if (traceResult.DidHitWorld() == false && FindByEntIndex(traceent.GetIndex()) == cube) {
            print("looking at a cube!")
            local currentcubestate = macros.GetFromTable(cubeStates, cubeIndex, false)
            if (currentcubestate == false) {
              ppmod.fire(cube,"disablemotion");
              ppmod.fire(cube,"disablepickup");
              cubeStates[cubeIndex.tointeger()] <- true;
            } else if (currentcubestate == true) {
              ppmod.fire(cube,"enablemotion");
              ppmod.fire(cube,"enablepickup");
              cubeStates[cubeIndex.tointeger()] <- false;
            } 
          } else {
            print("hit world.")
            print(traceResult.GetEntityClassname())
            print(traceResult.GetEntity())
            print(cube)
          }
      } else {
          print("didn't hit anything.")
      }
      
    })//end of cube hook function
  })//end of entire script for info ping detector
    local pingred1 = Entities.CreateByClassname("info_player_ping_detector");
    ppmod.fire(pingred1,"enable")
    ppmod.keyval(pingred1,"TeamToLookAt","2")
    ppmod.addscript(pingred1, "OnPingDetected",function() {
      print("pingdetected")
      ppmod.getall(["prop_weighted_cube"],function (cube) { /////////////////////////////////////////////1
      local blue = ppmod.get("blue");
      local red = ppmod.get("red");
      print("cubeishere!")
      local cubeIndex = cube.entindex();
      local traceSettings = TracePlus.Settings.new({
          priorityClasses = arrayLib.new("prop_weighted_cube"),
          errorTolerance = 100
      })
      local traceResult = TracePlus.FromEyes.Bbox(1024, FindByEntIndex(2), null, traceSettings)
      if (traceResult.DidHit()) {
        local traceent = traceResult.GetEntity()
        print(traceent.GetIndex())
          if (traceResult.DidHitWorld() == false && FindByEntIndex(traceent.GetIndex()) == cube) {
            print("looking at a cube!")
            local currentcubestate = macros.GetFromTable(cubeStates, cubeIndex, false)
            if (currentcubestate == false) {
              ppmod.fire(cube,"disablemotion");
              ppmod.fire(cube,"disablepickup");
              cubeStates[cubeIndex.tointeger()] <- true;
            } else if (currentcubestate == true) {
              ppmod.fire(cube,"enablemotion");
              ppmod.fire(cube,"enablepickup");
              cubeStates[cubeIndex.tointeger()] <- false;
            } 
          } else {
            print("hit world.")
            print(traceResult.GetEntityClassname())
            print(traceResult.GetEntity())
            print(cube)
          }
      } else {
          print("didn't hit anything.")
      }
      
    })//end of cube hook function 2
  })//end of entire script for info ping detector 2
  } else if (GetMapName() == "mp_coop_rat_maze") {
    // Setup EntFires

    EntFire("prop_laser_catcher","color","0 0 255")
    ppmod.fire(ppmod.get("prop_floor_button"),"color","0 255 0")
    ppmod.fire(ppmod.get("prop_floor_button",ppmod.get("prop_floor_button")),"color","255 0 0")
    EntFire("@exit_door","color","0 0 255")
    EntFire("InstanceAuto7-red_dropper-cube_dropper_prop","color","0 255 0")
    EntFire("InstanceAuto7-blue_dropper-cube_dropper_prop","color","255 0 0")
    EntFire("blue-station","color","255 0 0")
    EntFire("orange-station","color","0 255 0")

    // Setup Outputs

    ppmod.addscript(ppmod.get("prop_floor_button"),"OnPressed",function(activator,caller) {
      if (activator.GetName() != "red") {
        ppmod.fire(ppmod.get("prop_floor_button"),"pressout")
        EntFire("level_counter","subtract","1")
        ppmod.wait(function() {
          EntFire("RatCrusher","setposition","0.5")
        },0.05)
      }
    },0.0,-1,true)
    ppmod.addscript(ppmod.get("prop_floor_button"),"OnUnPressed",function(activator,caller) {
      if (activator.GetName() != "red") {
        EntFire("level_counter","add","1")
        ppmod.wait(function() {
          EntFire("RatCrusher","setposition","0.5")
        },0.05)
      }
    },0.0,-1,true)
    ppmod.addscript(ppmod.get("prop_floor_button",ppmod.get("prop_floor_button")),"OnPressed",function(activator,caller) {
      if (activator.GetName() != "blue") {
        ppmod.fire(ppmod.get("prop_floor_button",ppmod.get("prop_floor_button")),"pressout")
        EntFire("level_counter","subtract","1")
        ppmod.wait(function() {
          EntFire("RatCrusher","setposition","0.5")
        },0.05)
      }
    },0.0,-1,true)
    ppmod.addscript(ppmod.get("prop_floor_button",ppmod.get("prop_floor_button")),"OnUnPressed",function(activator,caller) {
      if (activator.GetName() != "blue") {
        EntFire("level_counter","add","1")
        ppmod.wait(function() {
          EntFire("RatCrusher","setposition","0.5")
        },0.05)
      }
    },0.0,-1,true)

    // Blue color

    ppmod.interval(function() {
      ppmod.fire("prop_weighted_cube","color","0 0 255")
    },1.5)
    ::cubeStates <- {};
    local pingblue1 = Entities.CreateByClassname("info_player_ping_detector");
    ppmod.fire(pingblue1,"enable")
    ppmod.keyval(pingblue1,"TeamToLookAt","3")
    ppmod.addscript(pingblue1, "OnPingDetected",function() {
      print("pingdetected")
      ppmod.getall(["prop_weighted_cube"],function (cube) { /////////////////////////////////////////////1
      local blue = ppmod.get("blue");
      local red = ppmod.get("red");
      print("cubeishere!")
      local cubeIndex = cube.entindex();
      local traceSettings = TracePlus.Settings.new({
          priorityClasses = arrayLib.new("prop_weighted_cube"),
          errorTolerance = 100
      })
      local traceResult = TracePlus.FromEyes.Bbox(1024, FindByEntIndex(1), null, traceSettings)
      if (traceResult.DidHit()) {
        local traceent = traceResult.GetEntity()
        print(traceent.GetIndex())
          if (traceResult.DidHitWorld() == false && FindByEntIndex(traceent.GetIndex()) == cube) {
            print("looking at a cube!")
            local currentcubestate = macros.GetFromTable(cubeStates, cubeIndex, false)
            if (currentcubestate == false) {
              ppmod.fire(cube,"disablemotion");
              ppmod.fire(cube,"disablepickup");
              cubeStates[cubeIndex.tointeger()] <- true;
            } else if (currentcubestate == true) {
              ppmod.fire(cube,"enablemotion");
              ppmod.fire(cube,"enablepickup");
              cubeStates[cubeIndex.tointeger()] <- false;
            } 
          } else {
            print("hit world.")
            print(traceResult.GetEntityClassname())
            print(traceResult.GetEntity())
            print(cube)
          }
      } else {
          print("didn't hit anything.")
      }
      
    })//end of cube hook function
  })//end of entire script for info ping detector
    local pingred1 = Entities.CreateByClassname("info_player_ping_detector");
    ppmod.fire(pingred1,"enable")
    ppmod.keyval(pingred1,"TeamToLookAt","2")
    ppmod.addscript(pingred1, "OnPingDetected",function() {
      print("pingdetected")
      ppmod.getall(["prop_weighted_cube"],function (cube) { /////////////////////////////////////////////1
      local blue = ppmod.get("blue");
      local red = ppmod.get("red");
      print("cubeishere!")
      local cubeIndex = cube.entindex();
      local traceSettings = TracePlus.Settings.new({
          priorityClasses = arrayLib.new("prop_weighted_cube"),
          errorTolerance = 100
      })
      local traceResult = TracePlus.FromEyes.Bbox(1024, FindByEntIndex(2), null, traceSettings)
      if (traceResult.DidHit()) {
        local traceent = traceResult.GetEntity()
        print(traceent.GetIndex())
          if (traceResult.DidHitWorld() == false && FindByEntIndex(traceent.GetIndex()) == cube) {
            print("looking at a cube!")
            local currentcubestate = macros.GetFromTable(cubeStates, cubeIndex, false)
            if (currentcubestate == false) {
              ppmod.fire(cube,"disablemotion");
              ppmod.fire(cube,"disablepickup");
              cubeStates[cubeIndex.tointeger()] <- true;
            } else if (currentcubestate == true) {
              ppmod.fire(cube,"enablemotion");
              ppmod.fire(cube,"enablepickup");
              cubeStates[cubeIndex.tointeger()] <- false;
            } 
          } else {
            print("hit world.")
            print(traceResult.GetEntityClassname())
            print(traceResult.GetEntity())
            print(cube)
          }
      } else {
          print("didn't hit anything.")
      }
      
    })//end of cube hook function 2
  })//end of entire script for info ping detector 2
  } else if (GetMapName() == "mp_coop_laser_crusher") {
    // Pre-Setup Things

    ::scns_cpm_pickupstate <- true

    // Setup EntFires
    EntFire("AutoInstance2-reflectocube_dropper_prop","color","0 0 255")
    ppmod.fire(ppmod.get("prop_laser_catcher",ppmod.get("prop_laser_catcher")),"color","0 255 0")
    ppmod.fire(ppmod.get("prop_laser_catcher",ppmod.get("prop_laser_catcher",ppmod.get("prop_laser_catcher"))),"color","255 0 0")
    EntFire("InstanceAuto34-red_dropper-cube_dropper_prop","color","0 255 0")
    EntFire("InstanceAuto34-blue_dropper-cube_dropper_prop","color","255 0 0")
    EntFire("InstanceAuto8-blue-station","color","255 0 0")
    EntFire("InstanceAuto8-orange-station","color","0 255 0")
    // Colored Laser Catchers
    ppmod.interval(function() {
      ppmod.getall(["prop_weighted_cube"],function (cubea) {
        ppmod.addscript(cubea,"OnBluePickup",function() {
          ::scns_cpm_pickupstate <- true
          print("bluepickup")
        })
        ppmod.addscript(cubea,"OnOrangePickup",function() {
          ::scns_cpm_pickupstate <- false
          print("orangepickup")
          print(scns_cpm_pickupstate)
        })
      })
    },3)
    ppmod.addscript(ppmod.get("prop_laser_catcher",ppmod.get("prop_laser_catcher")),"OnPowered",function() {
      if (scns_cpm_pickupstate == true) {
        EntFire("crusher_1_close_rl","trigger","",0.05)
      }
      print(scns_cpm_pickupstate)
    })
    ppmod.addscript(ppmod.get("prop_laser_catcher",ppmod.get("prop_laser_catcher",ppmod.get("prop_laser_catcher"))),"OnPowered",function() {
      if (scns_cpm_pickupstate == false) {
        EntFire("soup_platform_close_rl","trigger","",0.05)
      }
      print(scns_cpm_pickupstate)
    })
    ppmod.addscript(ppmod.get("prop_laser_catcher",ppmod.get("prop_laser_catcher")),"OnUnPowered",function() {
      if (scns_cpm_pickupstate == true) {
        EntFire("crusher_1_close_rl","trigger","",0.05)
      }
      print(scns_cpm_pickupstate)
    })
    ppmod.addscript(ppmod.get("prop_laser_catcher",ppmod.get("prop_laser_catcher",ppmod.get("prop_laser_catcher"))),"OnUnPowered",function() {
      if (scns_cpm_pickupstate == false) {
        EntFire("soup_platform_close_rl","trigger","",0.05)
      }
      print(scns_cpm_pickupstate)
    })

    // Blue color

    ppmod.interval(function() {
      ppmod.fire("prop_weighted_cube","color","0 0 255")
    },1.5)
    ::cubeStates <- {};
    local pingblue1 = Entities.CreateByClassname("info_player_ping_detector");
    ppmod.fire(pingblue1,"enable")
    ppmod.keyval(pingblue1,"TeamToLookAt","3")
    ppmod.addscript(pingblue1, "OnPingDetected",function() {
      print("pingdetected")
      ppmod.getall(["prop_weighted_cube"],function (cube) { /////////////////////////////////////////////1
      local blue = ppmod.get("blue");
      local red = ppmod.get("red");
      print("cubeishere!")
      local cubeIndex = cube.entindex();
      local traceSettings = TracePlus.Settings.new({
          priorityClasses = arrayLib.new("prop_weighted_cube"),
          errorTolerance = 100
      })
      local traceResult = TracePlus.FromEyes.Bbox(1024, FindByEntIndex(1), null, traceSettings)
      if (traceResult.DidHit()) {
        local traceent = traceResult.GetEntity()
        print(traceent.GetIndex())
          if (traceResult.DidHitWorld() == false && FindByEntIndex(traceent.GetIndex()) == cube) {
            print("looking at a cube!")
            local currentcubestate = macros.GetFromTable(cubeStates, cubeIndex, false)
            if (currentcubestate == false) {
              ppmod.fire(cube,"disablemotion");
              ppmod.fire(cube,"disablepickup");
              cubeStates[cubeIndex.tointeger()] <- true;
            } else if (currentcubestate == true) {
              ppmod.fire(cube,"enablemotion");
              ppmod.fire(cube,"enablepickup");
              cubeStates[cubeIndex.tointeger()] <- false;
            } 
          } else {
            print("hit world.")
            print(traceResult.GetEntityClassname())
            print(traceResult.GetEntity())
            print(cube)
          }
      } else {
          print("didn't hit anything.")
      }
      
    })//end of cube hook function
  })//end of entire script for info ping detector
    local pingred1 = Entities.CreateByClassname("info_player_ping_detector");
    ppmod.fire(pingred1,"enable")
    ppmod.keyval(pingred1,"TeamToLookAt","2")
    ppmod.addscript(pingred1, "OnPingDetected",function() {
      print("pingdetected")
      ppmod.getall(["prop_weighted_cube"],function (cube) { /////////////////////////////////////////////1
      local blue = ppmod.get("blue");
      local red = ppmod.get("red");
      print("cubeishere!")
      local cubeIndex = cube.entindex();
      local traceSettings = TracePlus.Settings.new({
          priorityClasses = arrayLib.new("prop_weighted_cube"),
          errorTolerance = 100
      })
      local traceResult = TracePlus.FromEyes.Bbox(1024, FindByEntIndex(2), null, traceSettings)
      if (traceResult.DidHit()) {
        local traceent = traceResult.GetEntity()
        print(traceent.GetIndex())
          if (traceResult.DidHitWorld() == false && FindByEntIndex(traceent.GetIndex()) == cube) {
            print("looking at a cube!")
            local currentcubestate = macros.GetFromTable(cubeStates, cubeIndex, false)
            if (currentcubestate == false) {
              ppmod.fire(cube,"disablemotion");
              ppmod.fire(cube,"disablepickup");
              cubeStates[cubeIndex.tointeger()] <- true;
            } else if (currentcubestate == true) {
              ppmod.fire(cube,"enablemotion");
              ppmod.fire(cube,"enablepickup");
              cubeStates[cubeIndex.tointeger()] <- false;
            } 
          } else {
            print("hit world.")
            print(traceResult.GetEntityClassname())
            print(traceResult.GetEntity())
            print(cube)
          }
      } else {
          print("didn't hit anything.")
      }
      
    })//end of cube hook function 2
  })//end of entire script for info ping detector 2
  } else if (GetMapName() == "mp_coop_teambts") {
    ppmod.wait(function() {
      scns_cpm_diskgreenonly <- function(activatora,activatorb) {
            if (activatora.GetName() == "blue") {
              EntFire("@dissolver","dissolve","disk")
              ppmod.wait(function() {
                EntFire("ptemplate_disk_spawn","forcespawn")
                ppmod.wait(function() {
                  ppmod.addscript("disk","OnPlayerPickup",function(activator,caller) {
                    scns_cpm_diskgreenonly(activator,caller)
                  },0.0,-1,true)
                  ppmod.fire(ppmod.get("disk",ppmod.get("disk")),"color","0 255 0")
                },1) 
              },0.05)
            }
          }
          ppmod.addscript("disk","OnPlayerPickup",function(activator,caller) {
            scns_cpm_diskgreenonly(activator,caller)
          },0.0,-1,true)
          ppmod.fire("disk","color","0 255 0")
          ppmod.addscript("AutoInstance1-$cleanser_name","OnDissolve",function(activator,caller) {
            ppmod.wait(function() {
              ppmod.addscript("disk","OnPlayerPickup",function(activator,caller) {
                scns_cpm_diskgreenonly(activator,caller)
              },0.0,-1,true)
              ppmod.fire(ppmod.get("disk",ppmod.get("disk")),"color","0 255 0")
            },1) 
          },0.0,-1,true)
    },3)
    
  }
} else if (GetDeveloperLevel() == 6) {
  ppmod.interval(function() {
      ppmod.fire(red,"addoutput","movetype 4")
      ppmod.fire(blue,"addoutput","movetype 4")
  }0.5);
} else if (GetDeveloperLevel() == 7) {
  ppmod.wait(function() {
    ::spc <- {};
    ::con_ent <- Entities.CreateByClassname("point_clientcommand");
    ::bcon_ent <- Entities.CreateByClassname("point_broadcastclientcommand");
    spc.portals <- [];

    spc.resize <- function() {
        if (spc.psize) {
            spc.psize = 0;
            ppmod.fire("prop_portal", "Resize", "32 55.9");
        } else {
            spc.psize = 1;
            ppmod.fire("prop_portal", "Resize", "32 56");
        }
        ppmod.fire("prop_portal", "SetLinkageGroupID", 99);
        ppmod.fire("prop_portal", "AddOutput", "PortalTwo 0");
    };

    local setupfunc = function() {
        ppmod.fire("prop_portal", "Fizzle");

        ppmod.interval(function() {
            if (ppmod.get("weapon_portalgun", ppmod.get("weapon_portalgun")) == null) return;

            ppmod.keyval("weapon_portalgun", "CanFirePortal1", true);
            ppmod.keyval("weapon_portalgun", "CanFirePortal2", false);

            // Additional setup depending on map
            // Details omitted for brevity...

            //ppmod.fire("prop_portal", "Fizzle");
            ppmod.fire("prop_portal", "SetLinkageGroupID", 99);
            ppmod.fire("prop_portal", "AddOutput", "PortalTwo 0");

            // Loop to find and manipulate portals
            for (local prt = ppmod.get("prop_portal"); prt; prt = ppmod.get("prop_portal", prt)) {
                local found = false;
                for (local i = 0; i < spc.portals.len(); i++) {
                    if (prt == spc.portals[i]) {
                        found = true;
                        break;
                    }
                }

                if (!found) {
                    spc.portals.push(prt);
                    ppmod.addoutput(prt, "OnPlacedSuccessfully", bcon_ent, "Command", "cl_cmdrate 60");
                    ppmod.addoutput(prt, "OnPlacedSuccessfully", bcon_ent, "Command", "script spc.resize()");
                    ppmod.addoutput(prt, "OnPlacedSuccessfully", bcon_ent, "Command", "cl_cmdrate 30", FrameTime());
                }

            }
            ppmod.fire("spc_spawnloop", "Kill");
            ppmod.fire(con_ent, "Command", "+duck", 0, red);

            ppmod.wait(function(pos = pos, ang = ang) {

              local red = ppmod.get("red");
              red.SetOrigin(pos);
              red.SetAngles(ang.x, ang.y, ang.z);

              ppmod.fire(bcon_ent, "Command", "fadein 0");
              ppmod.fire(bcon_ent, "Command", "debug_fixmyposition");
              ppmod.fire(con_ent, "Command", "-duck", 0, red);

              spc.redstuck <- pos.z;
              ppmod.interval(function(red = red) {

                if (red.GetOrigin().z == spc.redstuck) {
                  ppmod.fire(bcon_ent, "Command", "debug_fixmyposition");
                } else {
                  ppmod.get("spc_redstuck_loop").Destroy();
                }

              }, 0.5, "spc_redstuck_loop");

            }, 0.2);

        }, 0, "spc_spawnloop");

    };

    setupfunc(); // Initialize the function to start the bizarre portal mechanic
  },0.5)

  // ::con_ent2 <- Entities.CreateByClassname("point_servercommmand")
  // ::con_ent <- Entities.CreateByClassname("point_clientcommand");
  // ::bcon_ent <- Entities.CreateByClassname("point_broadcastclientcommand");
  // ppmod.keyval(scns_ent2,"targetname","scns_servercommand")
  // ppmod.fire(scns_ent2,"command","connectportals")
  ppmod.getall(["info_coop_spawn"], function (ent) {
    local vclip = ppmod.trigger(ent.GetOrigin(), Vector(32,32,72), "trigger_multiple")
    ppmod.addscript(vclip,"OnStartTouch",function() {
      ::spc <- {};
      ::con_ent <- Entities.CreateByClassname("point_clientcommand");
      ::bcon_ent <- Entities.CreateByClassname("point_broadcastclientcommand");
      spc.portals <- [];

      spc.resize <- function() {
          if (spc.psize) {
              spc.psize = 0;
              ppmod.fire("prop_portal", "Resize", "32 55.9");
          } else {
              spc.psize = 1;
              ppmod.fire("prop_portal", "Resize", "32 56");
          }
          ppmod.fire("prop_portal", "SetLinkageGroupID", 99);
          ppmod.fire("prop_portal", "AddOutput", "PortalTwo 0");
      };

      local setupfunc = function() {
          ppmod.fire("prop_portal", "Fizzle");

          ppmod.interval(function() {
              if (ppmod.get("weapon_portalgun", ppmod.get("weapon_portalgun")) == null) return;

              ppmod.keyval("weapon_portalgun", "CanFirePortal1", true);
              ppmod.keyval("weapon_portalgun", "CanFirePortal2", false);

              // Additional setup depending on map
              // Details omitted for brevity...

              //ppmod.fire("prop_portal", "Fizzle");
              ppmod.fire("prop_portal", "SetLinkageGroupID", 99);
              ppmod.fire("prop_portal", "AddOutput", "PortalTwo 0");

              // Loop to find and manipulate portals
              for (local prt = ppmod.get("prop_portal"); prt; prt = ppmod.get("prop_portal", prt)) {
                  local found = false;
                  for (local i = 0; i < spc.portals.len(); i++) {
                      if (prt == spc.portals[i]) {
                          found = true;
                          break;
                      }
                  }

                  if (!found) {
                      spc.portals.push(prt);
                      ppmod.addoutput(prt, "OnPlacedSuccessfully", bcon_ent, "Command", "cl_cmdrate 60");
                      ppmod.addoutput(prt, "OnPlacedSuccessfully", bcon_ent, "Command", "script spc.resize()");
                      ppmod.addoutput(prt, "OnPlacedSuccessfully", bcon_ent, "Command", "cl_cmdrate 30", FrameTime());
                  }

              }
              ppmod.fire("spc_spawnloop", "Kill");
              ppmod.fire(con_ent, "Command", "+duck", 0, red);

              ppmod.wait(function(pos = pos, ang = ang) {

                local red = ppmod.get("red");
                red.SetOrigin(pos);
                red.SetAngles(ang.x, ang.y, ang.z);

                ppmod.fire(bcon_ent, "Command", "fadein 0");
                ppmod.fire(bcon_ent, "Command", "debug_fixmyposition");
                ppmod.fire(con_ent, "Command", "-duck", 0, red);

                spc.redstuck <- pos.z;
                ppmod.interval(function(red = red) {

                  if (red.GetOrigin().z == spc.redstuck) {
                    ppmod.fire(bcon_ent, "Command", "debug_fixmyposition");
                  } else {
                    ppmod.get("spc_redstuck_loop").Destroy();
                  }

                }, 0.5, "spc_redstuck_loop");

              }, 0.2);

          }, 0, "spc_spawnloop");

      };

      setupfunc(); // Initialize the function to start the bizarre portal mechanic
      print("respawned")
    })
  })


} else if (GetDeveloperLevel() == 8) {
  Entities.FindByName(null,"red").SetTeam(3);
  Entities.FindByName(null,"blue").SetTeam(2);
  ppmod.wait(function(){
    if (GetMapName() == "mp_coop_lobby_3" || GetMapName() == "mp_coop_lobby_2") {
    EntFire("left_dlc_to_hub_destination","TeleportEntity","red")
    EntFire("right_dlc_to_hub_destination","TeleportEntity","blue")
    }
    SwapPlayerThing()
  },0.5)
} else if (GetDeveloperLevel() == 9) {
  if (GetMapName() == "mp_coop_wall_5") {
    local portal1 = entLib.CreateByClassname("linked_portal_door", {
      angles = "0 90 0",
      height = 64,
      partnername = "scns_portal2",
      startactive = 1,
      targetname = "scns_portal1",
      width = 128,
    })
    local portal2 = entLib.CreateByClassname("linked_portal_door", {
      angles = "0 0 0",
      height = 64,
      partnername = "scns_portal1",
      startactive = 1,
      targetname = "scns_portal2",
      width = 128,
    })
    portal1.SetOrigin(Vector(-2288,-1024,-192))
    portal2.SetOrigin(Vector(112,-1920,48))
    ppmod.wait(function() {
    portal1.fire(portal1,"open")
    portal2.fire(portal2,"open")
    })
  } else if (GetMapName() == "mp_coop_fan") {
    //local disk2 = entLib.CreateProp("prop_physics_override", Vector(1184, -26, -380), "models/props_gameplay/laser_disc.mdl")
    EntFire("ptemplate_diskz","ForceSpawn")
    ppmod.wait(function() {
      local brus = ppmod.trigger(Vector(-259.8, 881.89, 231.28), Vector(12, 20.3, 14), "trigger_multiple");
      local brush = pcapEntity(brus)
      local notdisk2 = ppmod.get("disk")
      local disk2 = pcapEntity(notdisk2)
      ppmod.keyval( brus,"filtername", "disk_filter2")
      ppmod.keyval( brus,"spawnflags", 8)
      disk2.SetName("disk2")
      disk2.SetOrigin(Vector(1184, -26, -380))
      local filteractivatorname = entLib.CreateByClassname("filter_activator_name", {
        health = 100,
        filtername = "disk2",
        targetname = "disk_filter2"
      })
      ppmod.keyval(brus,"filtername", "disk_filter2")
      //brush.addOutput("OnStartTouch", "hidden_disk", "turnon")
      brush.addOutput("OnStartTouch", "disk_spark", "sparkonce")
      ppmod.addscript(brus,"OnStartTouch", function(activator,caller) {
        if (activator.GetName() == "disk2")  {
        IncludeScript("SRC/aperturekit")
        ppmod.fire(activator,"kill")
        Precache("music/sp_under_potatos_v1_01.wav")
        Precache("music/sp_under_potatos_x1_01.wav")
        local RandomPullInt = 1
        if (RandomPullInt == 1) {
          Entities.FindByName(null,"@glados").EmitSound("music/sp_under_potatos_v1_01.wav")
        } else if (RandomPullInt == 2) {
          Entities.FindByName(null,"@glados").EmitSound("music/sp_under_potatos_x1_01.wav")
        } else {
          dev.warning("RandomPullInt does not exist!")
        }
        printl("Output triggered!")
        }
      },0.0,-1,true)
    },2)
  }
}else if (GetDeveloperLevel() == 10) {
  EntFire("@command","Command","sv_cheats 1")
  if (GetMapName() == "mp_coop_doors") {
    local cube = ppmod.create("prop_weighted_cube").then(function (cube) {
      cube.SetOrigin(Vector(-10288.353,-990.382,64.031));
    });
    ppmod.interval(function() {
      EntFire("weapon_portalgun","addoutput","canfireportal1 false")
      EntFire("weapon_portalgun","addoutput","canfireportal2 false")
    },1)
    //simplest code ever, over 8 hours of work put into debugging 4/25/24
  } else if (GetMapName() == "mp_coop_race_2") {
    local cube = ppmod.create("prop_weighted_cube").then(function (cube) {
      cube.SetOrigin(Vector(-1167.28,-208,0));
      EntFireByHandle(cube, "targetname", "scns_startercube", 0.0, null, null)
    });
    local button1 = ppmod.get("prop_button"); //top right button
    local button2 = ppmod.get("prop_button",button1); // bottom right button
    local button3 = ppmod.get("prop_button",button2); // first button that appears
    local button4 = ppmod.get("prop_button",button3); // bottom left button
    local button5 = ppmod.get("prop_button",button4); // top left button
    local brus = ppmod.trigger(Vector(-1792,-96,-152), Vector(288,224,80), "trigger_multiple");
    local brush = pcapEntity(brus)
    ppmod.keyval(brus,"spawnflags", 8)
    ppmod.addscript(brus,"OnStartTouch", function(activator,caller) {
      print("something detected")
          activator.SetOrigin(Vector(-1167.28,-208,0))
      },0.0,-1,true)
    local brus2 = ppmod.trigger(Vector(-368, -384 ,-0.12), Vector(32,122,64), "trigger_once");
    local brush2 = pcapEntity(brus2)
    ppmod.fire("trigger_multiple","enable")
    ppmod.keyval(brush2,"spawnflags", 4097)
    ppmod.addscript(brus2,"OnStartTouch", function(activator,caller) {
        ppmod.fire("trigger_portal_cleanser","enable")
      },0.0,1,true)
    ppmod.fire(button3,"kill")
    ppmod.fire("trigger_portal_cleanser","disable")
    ppmod.fire("switch_door_2_indicator","uncheck")
    local button = ppmod.button("prop_floor_button", Vector(-1792,64,-55.969)).then(function (button) {
    
    button.OnPressed(function () {
      ppmod.fire("paneldoor-airlock_entry_door_open_rl", "trigger");
      ppmod.fire("timer_training_light_toggle", "SetTextureIndex","1");
      ppmod.fire("switch_door_2_indicator","check")
    });

    button.OnUnpressed(function () {
      print("test")
      ppmod.fire("paneldoor-airlock_entry_door_close_rl", "trigger");
      ppmod.fire("timer_training_light_toggle", "SetTextureIndex","0");
      ppmod.fire("switch_door_2_indicator","uncheck")
    });

  });
  local trigger1 = ppmod.trigger(Vector(-1216, -416, 1.92), Vector(16, 64, 66), "trigger_portal_cleanser");
  ppmod.keyval(trigger1,"spawnflags","4097");
  ppmod.keyval(trigger1,"targetname","scns_triggerclean2")
  ppmod.fire("@command","command","ent_bbox scns_triggerclean2")
  ppmod.fire(trigger1,"Enable");

  local trigger2 = ppmod.trigger(Vector(96 ,-160, 1.92), Vector(96, 96, 66), "trigger_portal_cleanser");
  ppmod.keyval(trigger2,"targetname","scns_triggerclean3")
  ppmod.fire("@command","command","ent_bbox scns_triggerclean3")
  ppmod.keyval(trigger2,"spawnflags","4097");
  ppmod.fire(trigger2,"Enable");
  local trigger3 = ppmod.trigger(Vector(96, -608, 1.92), Vector(96, 96, 66), "trigger_portal_cleanser");
  ppmod.keyval(trigger3,"targetname","scns_triggerclean4")
  ppmod.fire("@command","command","ent_bbox scns_triggerclean4")
  ppmod.keyval(trigger3,"spawnflags","4097");
  ppmod.fire(trigger3,"Enable");
  //i literally had to modify functions within ppmod itself to make this lol 4/27/24

  } else if (GetMapName() == "mp_coop_laser_2") {
    local lasercatcher = ppmod.create("prop_laser_catcher").then(function(lasercatcher) {
      lasercatcher.SetOrigin(Vector(-1927,-192,-544));
      ppmod.addoutput(lasercatcher, "onpowered", "lgrid_laser_counter", "add", "1");
      ppmod.addoutput(lasercatcher, "onunpowered", "lgrid_laser_counter", "subtract", "1");
    })
    local lasercatcher2 = ppmod.create("prop_laser_catcher").then(function(lasercatcher2) {
      lasercatcher2.SetOrigin(Vector(933,0,-512));
      ppmod.fire(lasercatcher2,"addoutput","angles 0 180 0")
      ppmod.addoutput(lasercatcher2, "onpowered", "lgrid_laser_counter_2", "add", "1");
      ppmod.addoutput(lasercatcher2, "onunpowered", "lgrid_laser_counter_2", "subtract", "1");
      ppmod.fire(lasercatcher2,"targetname","scns_lasercatcher2")
      //ppmod.fire("@command","command","ent_bbox scns_lasercatcher2")
    })
    local laseremitter = ppmod.create("env_portal_laser").then(function(laseremitter) {
      laseremitter.SetOrigin(Vector(190,0,-184));
      laseremitter.SetAngles(90, 0, 0)
      ppmod.fire(laseremitter,"turnon")
    })
    local cube = ppmod.create("ent_create_portal_reflector_cube").then(function (cube) {
      cube.SetOrigin(Vector(-1408,0,-512));
      cube.SetAngles(0, 180, 0)
    });
    local cube2 = ppmod.create("ent_create_portal_reflector_cube").then(function (cube2) {
      cube2.SetOrigin(Vector(144,72,-556));
      cube2.SetAngles(0, 180, 0)
    });
    local cube3 = ppmod.create("prop_weighted_cube").then(function (cube3) {
      cube3.SetOrigin(Vector(832,-32,-555));
    });
    local cube4 = ppmod.create("prop_weighted_cube").then(function (cube4) {
      cube4.SetOrigin(Vector(992,-32,-432));
    });
    //local filteractivatorname = entLib.CreateByClassname("filter_activator_class", {
    //    health = 100,
    //    filterclass = "player",
    //    negated = 0
    //    targetname = "vclip_filter1"
    //  })
    //local vclip = ppmod.brush(Vector(-152,0,-512), Vector(24, 64, 64), "func_clip_vphysics").then(function(vclip) {
    //  ppmod.keyval(vclip,"filtername","vclip_filter1")
    //})

    local cubeevildestroyer = ppmod.get("InstanceAuto24-$cleanser_name")
    cubeevildestroyer.SetOrigin(Vector(-704,0,-512)) //fixes cubes from being able to be destroyed

    ppmod.keyval("lgrid_laser_counter","max",3)
    ppmod.keyval("lgrid_laser_counter_2","max",3)
    ppmod.wait(function() {
      ppmod.fire("lgrid_door_open","enablerefire")
      ppmod.fire("lgrid_door_close","enablerefire")
      ppmod.fire("lgrid_door_close","enable")
      ppmod.fire("lgrid_door_open","enable")
      ppmod.fire("ramp_up_relay1","enablerefire")
      ppmod.fire("ramp_up_relay1","enable")
      ppmod.fire("ramp_down_relay1","enablerefire")
      ppmod.fire("ramp_down_relay1","enable")
    },1)
    EntFire("npc_portal_turret_floor","addoutput","usesuperdamagescale 1")
    //This level is done 4/27/24
  } else if (GetMapName() == "mp_coop_rat_maze") {
    // Kill Original laser catcher so we can replace it.
    // Kills the thing that does the taunt as well.
    EntFire("prop_laser_catcher","kill")
    EntFire("coop_man_give_taunt","kill")
    EntFire("new_laser","turnoff")
    
    // Create Entities
    // PrecacheModel("models/props/laser_catcher_center.mdl")
    // local mathcounter = entlib.CreateByClassname("math_counter",{
    //  startvalue = 0,
    //  max = 2,
    //  StartDisabled = 0,
    //  min = 0,
    //  targetname = "lgrid_laser_counter_1"
    // })
    local mathcounter = entLib.CreateByClassname("math_counter", {
      startvalue = 0,
      max = 2,
      StartDisabled = 0,
      min = 0,
      targetname = "lgrid_laser_counter_1",
    })
    local laser_catcher = ppmod.create("prop_laser_catcher").then(function (laser_catcher) {
      laser_catcher.SetOrigin(Vector(373,-224,-448));
      laser_catcher.SetAngles(0,180,0)
      ppmod.addoutput(laser_catcher,"OnPowered","lgrid_laser_counter_1","add","1",0.0,-1)
      ppmod.addoutput(laser_catcher,"OnUnPowered","lgrid_laser_counter_1","subtract","1",0.0,-1)
      ppmod.addoutput(laser_catcher,"UnPowered","button1_texture_changer","SetTextureIndex",1,0.0,-1)
      ppmod.addoutput(laser_catcher,"UnUnPowered","button1_texture_changer","SetTextureIndex",0,0.0,-1)
      ppmod.keyval(laser_catcher,"skin","0")
      ppmod.keyval(laser_catcher,"drawinfastreflection","0")
      ppmod.keyval(laser_catcher,"SkinType","0")
    });
    local laser_relay = ppmod.create("prop_laser_relay").then(function (laser_relay) {
      laser_relay.SetOrigin(Vector(-352,544,-376))
      laser_relay.SetAngles(Vector(0,0,0))
      // ppmod.keyval(laser_relay,"targetname","lgrid_laser_relay_1")
    })
    local cube = ppmod.create("ent_create_portal_reflector_cube").then(function (cube) {
      cube.SetOrigin(Vector(-864,544,-576));
      cube.SetAngles(0, 0, 0)
    });
    local laser = ppmod.create("env_portal_laser").then(function (laser) {
      laser.SetOrigin(Vector(-858,544,-500));
      laser.SetAngles(90, 0, 0)
    });
    // Outputs and KeyValues for pcapture lib and unused stuff
    // mathcounter.addOutput("OnHitMax", "@exit_door", "open")
    ppmod.fire(laser_relay,"addoutput","OnUnPowered lgrid_laser_counter_1:subtract:1:0:-1")
        ppmod.fire(laser_relay,"addoutput","OnPowered lgrid_laser_counter_1:add:1:0:-1")
        ppmod.fire(laser_relay,"addoutput","OnPowered @command:command:\"script_execute atlasradio\":0.0:-1") // <targetname>:<inputname>:<parameter>:<delay>:<max times to fire, 1 means once and -1 means infinite>
    local mathcounterppmod = ppmod.get(mathcounter.GetName())
    ppmod.addoutput(mathcounterppmod,"OnHitMax","@exit_door","open")
    
    // ppmod.keyval(laser_catcher,"model","models/props/laser_catcher_center.mdl") //Wanted to have the normal laser catcher model - It's already precached, man what you talking about.
    // laser_catcher.SetModel("models/props/laser_catcher_center.mdl")

  //I Originally tried a 'Death Box' type chamber with this but it didn't end up working very well.
  //this level is maybe the most complex and took the least amount of time to make - Old comment.
  } else if (GetMapName() == "mp_coop_laser_crusher") {
    local vclip = ppmod.brush(Vector(2432,-1416,48), Vector(256,8,144), "func_brush")
    triggerclean1 <- ppmod.trigger(Vector(1952,-1376,64), Vector(64,16,64), "trigger_portal_cleanser");
    ppmod.keyval(triggerclean1,"spawnflags","4097");
    ppmod.keyval(triggerclean1,"targetname","scns_triggerclean1");
    ppmod.fire("@command","command","ent_bbox scns_triggerclean1")
    ppmod.fire(triggerclean1,"Enable");
    local cube = ppmod.create("prop_weighted_cube").then(function (cube) {
      cube.SetOrigin(Vector(2080,-1168,16));
      cube.SetAngles(0, 180, 0)
    });
    ppmod.fire("crasher2","open")
    trigger1 <- ppmod.trigger(Vector(2112,-1392,128), Vector(64,16,128), "trigger_multiple");
    ppmod.keyval(trigger1,"damagetype","0");
    ppmod.keyval(trigger1,"spawnflags","4097");
    ppmod.keyval(trigger1,"damage","100");
    ppmod.fire(trigger1,"Enable");
    ppmod.addscript(trigger1,"OnStartTouch",function(activator,caller) {
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
    },0.0,-1,true)
    trigger2 <- ppmod.trigger(Vector(2944,-1536,144), Vector(96,96,144), "trigger_multiple");
    ppmod.keyval(trigger2,"damagetype","0");
    ppmod.keyval(trigger2,"spawnflags","4097");
    ppmod.keyval(trigger2,"damage","100");
    ppmod.fire(trigger2,"Enable");
    ppmod.addscript(trigger2,"OnStartTouch",function(activator,caller) {
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
    },0.0,-1,true)
    ShowKillBBox <- true
    ppmod.interval(function() {
      if (ShowKillBBox == true) {
        dev.DrawEntityBBox(trigger1, 0.5)
        dev.DrawEntityBBox(trigger2, 0.5)
      } else {
        return
      }
    },0.5)
    IncludeScript("SRC/aperturekit")
    Precache("world/laser_cut.wav");
    local deathswapbutton = ppmod.button("prop_floor_button", Vector(2240,-928,4)).then(function (button) {
    button.OnPressed(function () {
      ShowKillBBox <- false
      local blue = ppmod.get("blue")
      print("pressed");
      ppmod.fire(trigger1,"disable");
      ppmod.fire(trigger2,"disable");
      blue.EmitSound("world/laser_cut.wav")
    });

    button.OnUnpressed(function () {
      ShowKillBBox <- true
      local blue = ppmod.get("blue")
      print("unpressed");
      ppmod.fire(trigger1,"Enable");
      ppmod.fire(trigger2,"Enable");
      blue.EmitSound("world/laser_cut.wav")
    });
    })
  } else if (GetMapName() == "mp_coop_teambts") {
    brush <- ppmod.brush(Vector(1920,-3383,5888), Vector(32,75,16), "func_brush")
    brush2 <- ppmod.brush(Vector(1920,-3400,5920), Vector(32,24,16), "func_brush")
    ppmod.interval(function() {
      EntFire("weapon_portalgun","addoutput","canfireportal1 false")
      EntFire("weapon_portalgun","addoutput","canfireportal2 false")
      dev.DrawEntityBBox(brush, 0.5)
      dev.DrawEntityBBox(brush2, 0.5)
    },0.5)
    //wanted to make a switch thing
    //
    //local staticswitch = entLib.CreateProp("prop_static", Vector(546,-3221,5695), "models/props_gameplay/circuit_breaker_box.mdl")
    //local dynamcswitch = entLib.CreateProp("prop_static", Vector(539,-3218,5700), "models/props_gameplay/circuit_breaker_lever.mdl")
    //local brus = ppmod.brush(Vector(971,-3010,5693), Vector(5,1,1), "func_brush");
    //local brush = pcapEntity(brus)
    //brush.SetKeyValue("angles","0 0 0")
    //brush.SetKeyValue("disableflashlight",0)
    //brush.SetKeyValue("disablereceiveshadows",0)
    //brush.SetKeyValue("disableshadows",0)
    //brush.SetKeyValue("distance",161)
    //brush.SetKeyValue("dmg",0)
    //brush.SetKeyValue("drawinfastreflection",0)
    //brush.SetKeyValue("forceclosed",0)
    //brush.SetKeyValue("health",0)
    //brush.SetKeyValue("ignoreclosed",0)
    //brush.SetKeyValue("lip",0)
    //brush.SetKeyValue("locked_sentence",0)
    //brush.SetKeyValue("loopmovesound",0)
    //brush.SetKeyValue("renderamt",255)
    //brush.SetKeyValue("rendercolor","255 255 255")
    //brush.SetKeyValue("renderfx",0)
    //brush.SetKeyValue("rendermode",0)
    //brush.SetKeyValue("shadowdepthnocache",0)
    //brush.SetKeyValue("wait",0.25)
    //brush.SetKeyValue("solidbsp",0)
    //brush.SetKeyValue("unlocked_sentence",0)
    //brush.SetKeyValue("spawnflags",384)
    //brush.SetKeyValue("targetname","scns_lever1")
    //brush.SetKeyValue("spawnpos",0)
    //brush.SetKeyValue("speed",0)
    //brush.AddOutput("OnFullyOpen","lever_2-cancel_close","trigger")

    //IM DONE WITH THE DEMO!!!! 4/27/24
  }
} else if (GetDeveloperLevel() == 11) {
  local myEntity = entLib.FindByName("blue")
  dev.DrawEntityBBox(myEntity,60) // Draw the bounding box for 5 seconds
} else if (GetDeveloperLevel() == 12) {
  if (GetMapName() == "mp_coop_lobby_3") {return}
  // Precache("music/sp_a4_finale4_b1.wav")
  // local ambient = Entities.CreateByClassname("ambient_generic")
  // ppmod.keyval(ambient,"cspinup",0)
  // ppmod.keyval(ambient,"fadeinsecs",0)
  // ppmod.keyval(ambient,"fadeoutsecs",0)
  // ppmod.keyval(ambient,"health",0)
  // ppmod.keyval(ambient,"lfomodpitch",0)
  // ppmod.keyval(ambient,"lfomodvol",0)
  // ppmod.keyval(ambient,"volstart",0)
  // ppmod.keyval(ambient,"lforate",0)
  // ppmod.keyval(ambient,"spinup",0)
  // ppmod.keyval(ambient,"spinup",0)
  // ppmod.keyval(ambient,"lfotype",0)
  // ppmod.keyval(ambient,"message","music/sp_a4_finale4_b1.wav")
  // ppmod.keyval(ambient,"pitch",100)
  // ppmod.keyval(ambient,"spindown",0)
  // ppmod.keyval(ambient,"pitchstart",100)
  // ppmod.keyval(ambient,"preset",0)
  // ppmod.keyval(ambient,"spawnflags",1)
  // ppmod.keyval(ambient,"radius",1250)
  
  // EntFireByHandle(ambient, "playsound", "", 0.0, null, null)
  // script TimeDelay(5,"music/sp_a2_bts1_b1.wav","changelevel mp_coop_rat_maze","labs/potato_timer_01.wav",false,true,"music/sp_a4_finale1_b5.wav",true)
  // TimeDelay(300,"music/sp_a2_bts1_b1.wav","restart_level","labs/potato_timer_01.wav",true,true,"music/sp_a4_tb_catch_c1b.wav",true)
  // TimeDelay(300,"music/sp_a4_finale1_b1.wav","restart_level","labs/potato_timer_01.wav",true,true) // Course 1
  // TimeDelay(105,"music/sp_a2_bts1_b1.wav","restart_level","labs/potato_timer_01.wav",true,true,true) // Final Chamber
  // TimeDelay(300,"music/sp_a4_finale4_b1.wav","restart_level","labs/potato_timer_01.wav",true,true) // Course 2-3
  // TimeDelay(105,"music/sp_a4_finale4_b2.wav","restart_level","labs/potato_timer_01.wav",true,true) // Course 5
  // sound/music/sp_a2_bts1_b1.wav
  //script TimeDelay(360,"music/sp_a4_finale4_b2.wav","transition_map","labs/potato_timer_01.wav",true,true,"music/sp_a4_finale4_b2.wav",true)
  // script FinalTimeDelay(50,"music/sp_a2_bts1_b1.wav","restart_level","labs/potato_timer_01.wav",true,true,"music/sp_a4_finale4_b5.wav",true)
} else if (GetDeveloperLevel() == 13) {
  TimeDelay(180,"","script KillPlayer(1);script KillPlayer(2)","",true,true)
  ppmod.interval(function() {
    TimeDelay(180,"","script KillPlayer(1);script KillPlayer(2)","",true,true)
  },180)
} else if (GetDeveloperLevel() == 14) {
  EntFire("player","addoutput","solid 0")
  ppmod.wait(function():() {
      EntFire("player","addoutput","solid 6")
  },4)
} else if (GetDeveloperLevel() == 15) {
  ppmod.interval(function() {
    ppmod.fire(FindByEntIndex(3),"addoutput","teamnumber -1")
  },2)
  ppmod.fire("player","addoutput","solid 4")
  local ent = null;     
  while (ent = Entities.FindByClassname(ent,"prop_dynamic")) {
    local entname = ent.GetName()
    if (entname == "orange-station"||macros.GetPostfix(entname) == "-station") {
      local pcapent = entLib.FromEntity(ent)
      if (pcapent.GetSkin() == 1) {
        local entorigin = ent.GetOrigin()
        local entx = entorigin.x
        local enty = entorigin.y
        local entz = entorigin.z
        print(entx)
        print(enty)
        print(entz)
        ppmod.fire(ent,"color","0 0 0") 
      }

    }
  }
} else if (GetDeveloperLevel() == 16) {
  try {
    for (local boxdropper; boxdropper = Entities.FindByClassname(boxdropper, "prop_dynamic");) {
      if (boxdropper.GetModelName() == "models/props_underground/underground_boxdropper.mdl") {
        EntFireByHandle(boxdropper,"setdefaultanimaion","open_idle",3.0,null,null)
        EntFireByHandle(boxdropper,"setanimation","open_idle",3.0,null,null)
      }
    }
  } catch (exception) {
    ppmod.interval(function() {
      print("doesn't work!")
    })
  }
  
}
}));

// script TimeDelay(75,"music/sp_a2_bts1_b1.wav","changelevel mp_coop_rat_maze","labs/potato_timer_01.wav",false,true,"music/sp_a4_finale1_b5.wav",true)
