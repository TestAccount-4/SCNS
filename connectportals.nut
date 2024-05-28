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