if (!("Entities" in this)) return;
IncludeScript("ppmod3.nut");
if ("spc" in this) return;

::spc <- { ss = false };
::con_ent <- Entities.CreateByClassname("point_clientcommand");
::bcon_ent <- Entities.CreateByClassname("point_broadcastclientcommand");
::con <- function(str) { ppmod.fire(bcon_ent, "Command", str) }

local auto = Entities.CreateByClassname("logic_auto");
ppmod.addscript(auto, "OnNewGame", "spc.start()", 2);
ppmod.addscript(auto, "OnMapTransition", "spc.restart()", 2);

local spawner = Entities.CreateByClassname("info_coop_spawn");
spawner.SetOrigin(Vector(65536, 65536, 65536));
ppmod.keyval(spawner, "Enabled", 1);
ppmod.fire(spawner, "SetAsActiveSpawn");

spc.start <- function () {

  // Destroy all named portals to prevent linkage ID overlapping
  if (GetMapName().tolower() != "sp_a1_intro2") {
    local portal = null;
    while (portal = ppmod.get("prop_portal", portal)) {
      if (portal.GetName().len()) portal.Destroy();
    }
  }

  /*
    We cannot proceed unless we are sure that red has connected.
    To ensure this we rely on a quirk of co-op where player position
    gets set twice. The second time marks the end of loading and the
    start of player spawning. We find the theoretical bounding box
    of the world and set the player even further than that. The only
    way to get back is to get teleported. This is done on the Z axis
    to eliminate other unforeseen movement and to potentially take
    advantage of gravity, further stabilizing this approach.
  */

  local lowest = 0, ent = null;
  while (ent = Entities.Next(ent)) {
    if (!ent || !ent.IsValid()) continue;
    lowest = min(lowest, ent.GetOrigin().z + ent.GetBoundingMins().z);
  }
  lowest -= 1024;

  local blue = ppmod.get("blue");

  // Server cvars can be set before red connects.
  ppmod.fire(con_ent, "Command", "sv_maxcmdrate 60", 0, blue);
  ppmod.fire(con_ent, "Command", "sv_cheats 1", 0, blue);

  // Attempt to hide any flashy, hacky teleportation
  ppmod.fire(bcon_ent, "Command", "fadeout 0");

  blue.SetOrigin(Vector(0, 0, lowest));

  ppmod.interval(function(lowest = lowest) {

    local blue = ppmod.get("blue");
    local red = ppmod.get("red");

    if (red && red.IsValid() && blue.GetOrigin().z > lowest || spc.ss) {

      ppmod.get("spc_red_loop").Destroy();

      ppmod.fire(bcon_ent, "Command", "fadeout 0");

      if (GetMapName().tolower().slice(0, 2) == "mp") {
        
        ppmod.fire(bcon_ent, "Command", "changelevel sp_a1_intro2");

      } else {
        switch (GetMapName().tolower()) {

          case "sp_a1_intro2" : {
            ppmod.fire("block_boxes", "Kill");
            ppmod.fire(bcon_ent, "Command", "god");
            break;
          }
          case "sp_a1_intro3" : {
            ppmod.fire("player_clips", "Kill");
            ppmod.fire("backtrack_brush", "Kill");
            ppmod.addscript("pickup_portalgun_rl", "OnTrigger", spc.enableguns);
            break;
          }
          case "sp_a1_intro4" : {
            ppmod.fire("glass_pane_1_door_1", "Open");
            ppmod.fire("glass_pane_fractured_model", "Enable");
            ppmod.fire("glass_pane_intact_model", "Kill");
            ppmod.fire("glass_pane_1_door_1_blocker", "Kill");
            ppmod.fire("glass_shard", "Break");
            ppmod.fire("aud_ramp_break_glass", "Kill");
            break;
          }

        }
      }

      ppmod.fire(bcon_ent, "Command", "alias reload restart_level");
      ppmod.keyval("player_loadsaved", "renderamt", 0);

      ppmod.fire(bcon_ent, "Command", "alias upgrade_portalgun script spc.enableguns()");
      ppmod.fire(bcon_ent, "Command", "alias upgrade_potatogun script spc.enableguns()");

      local blue = ppmod.get("blue");
      blue.SetOrigin(ppmod.get("info_player_start").GetOrigin());

      /*
        To prevent most door-related softlocks, this detects whether
        a door was closed by a button or laser, or by some other
        means like a trigger. If it's the latter, we add an output
        to it which makes it immediately re-open itself after all
        associated entity IO has been fired. If there's a brush near
        the door, remove it.
      */

      spc.unpress <- false;
      local button_func = function() {
        local timer = ppmod.get("spc_timer");
        if (timer && timer.IsValid) timer.Destroy();
        spc.unpress = true;
        ppmod.wait("spc.unpress = false", FrameTime() * 3, "spc_timer");
      }

      spc.doorfunc <- function(ent) {
        if (!spc.unpress) {
          ppmod.addoutput(ent, "OnFullyClosed", "!self", "Open");
          local brush = null;
          while (brush = Entities.FindInSphere(brush, ent.GetOrigin(), 32)) {
            if (brush && brush.IsValid() && brush.GetClassname() == "func_brush") brush.Destroy();
          }
        }
      }

      ppmod.addscript("prop_floor_button", "OnUnPressed", button_func);
      ppmod.addscript("prop_laser_catcher", "OnUnPowered", button_func);
      ppmod.addscript("prop_testchamber_door", "OnClose", "spc.doorfunc(self)");
      ppmod.addoutput("linked_portal_door", "OnClose", "!self", "Open");

      // Hacky way to keep underground doors open.
      local underdoor = null;
      while (underdoor = ppmod.get("models/props_underground/underground_door_dynamic.mdl", underdoor)) {
        ppmod.fire(underdoor, "SetDefaultAnimation", "Open");
      }

      // Open all portals, prevent entity IO from affecting them.
      ppmod.fire("func_areaportal", "Open");
      ppmod.keyval("func_areaportal", "Targetname", "");

      spc.psize <- 0;

      ppmod.wait(function() {

        ppmod.fire("prop_portal", "Fizzle");
        local blue = ppmod.get("blue");
        local red = ppmod.get("red");
        local pos = blue.GetOrigin() + Vector(0, 0, 74);
        local ang = blue.GetAngles();

        /*
          During the final teleportation, red might get stuck if
          there's not enough free space above blue. To try to squeeze
          the player in regardless, we first force them to crouch,
          then run debug_fixmyposition regularly until red's Z
          coordinate changes. This seems to work on (most) single-
          player campaign maps.
        */

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

        local spawner = ppmod.get("info_coop_spawn");
        spawner.SetOrigin(blue.GetOrigin());
        spawner.SetAngles(ang.x, ang.y, ang.z);

        /*
          To achieve this bizarre single-portal mechanic, we have to
          break the portal linkage in a way that the game struggles
          to deal with. Specifically, red's portal prediction seems
          to lag behind. Resizing the portals after they're open on
          both clients seems to fix this. The current approach is to
          send a client-side console command from orange that runs
          this script function - that's the first step, which ensures
          that both players are synced up. The function itself simply
          toggles the height of the portals between 55.9 and 56.
        */

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
        }

        spc.portals <- [];

        local setupfunc = function() {

          ppmod.fire("prop_portal", "Fizzle");

          ppmod.interval(function() {

            if (ppmod.get("weapon_portalgun", ppmod.get("weapon_portalgun")) == null) return;

            ppmod.keyval("weapon_portalgun", "CanFirePortal1", true);
            ppmod.keyval("weapon_portalgun", "CanFirePortal2", false);
            
            switch (GetMapName().tolower()) {

              case "sp_a1_intro1" :
              case "sp_a1_intro2" :
              case "sp_a1_intro3" :
              case "sp_a2_intro"  :
              {
                ppmod.keyval("weapon_portalgun", "CanFirePortal1", false);
                ppmod.keyval("weapon_portalgun", "CanFirePortal2", false);

                break;
              }

            }

            ppmod.fire("prop_portal", "Fizzle");
            ppmod.fire("prop_portal", "SetLinkageGroupID", 99);
            ppmod.fire("prop_portal", "AddOutput", "PortalTwo 0");

            /*
              Before any portals are been placed, the prop_portal
              entities don't exist yet. Here, we actively look for new
              occurances, add the required entity IO, and push them to
              a list.
            */

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

          }, 0, "spc_spawnloop");

        }

        local playerdie = Entities.CreateByClassname("trigger_brush");
        ppmod.keyval(playerdie, "Targetname", "game_playerdie");
        ppmod.addscript(playerdie, "OnUse", setupfunc);

        setupfunc();

      }, 0.2);

      ppmod.fire("info_landmark_exit", "Kill");

    }

  }, 0, "spc_red_loop");

}

spc.restart <- function () {

  local lowest = 0, ent = null;
  while (ent = Entities.Next(ent)) {
    if (!ent || !ent.IsValid()) continue;
    lowest = min(lowest, ent.GetOrigin().z + ent.GetBoundingMins().z);
  }
  lowest -= 1024;

  local blue = ppmod.get("blue");
  blue.SetOrigin(Vector(0, 0, lowest));

  ppmod.interval(function (lowest = lowest) {

    local blue = ppmod.get("blue");
    local red = ppmod.get("red");

    if (red && red.IsValid() && blue.GetOrigin().z > lowest || spc.ss) {
      ppmod.fire("info_landmark_exit", "Kill");
      ppmod.fire(bcon_ent, "Command", "restart_level");
    }

  }, 0, "spc_red_loop");

}

spc.enableguns <- function () {

  ppmod.keyval("weapon_portalgun", "CanFirePortal1", true);
  ppmod.keyval("weapon_portalgun", "CanFirePortal2", false);

}
