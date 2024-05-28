IncludeScript("ppmod3.nut");
//createbrush <- function(e) {
//    local player = GetPlayer()
//    local playerorigin = player.GetOrigin()
//    local brush = Entities.CreateByClassname("func_brush");
//    brush.SetAbsOrigin(Vector(playerorigin.x,playerorigin.y - 5,playerorigin.z));
//    brush.SetAngles(0,0,0);
//    brush.SetSize(Vector(-30, -1, -30), Vector(30, 1, 30));
//    brush.__KeyValueFromInt("Solid", 3);
//}

createturret <- function(pos) {
    local player = ppmod.get("blue")
    local playerorigin = player.GetOrigin()
    local brush = Entities.CreateByClassname("npc_portal_turret_floor");
    brush.SetAbsOrigin(playerorigin);
    brush.SetAngles(0,0,0);
    brush.__KeyValueFromInt("allowshootthroughportals", 0);
    brush.__KeyValueFromInt("usesuperdamagescale", 0);
    brush.__KeyValueFromInt("usedasactor", 0);
    brush.__KeyValueFromInt("collisiontype", 0);
    brush.__KeyValueFromInt("turretrange", 1024);
    brush.__KeyValueFromInt("damageforce", 1);
    brush.__KeyValueFromInt("disablemotion", 0);
    brush.__KeyValueFromString("targetname", "");
    brush.__KeyValueFromInt("gagged",0);
    brush.__KeyValueFromInt("spawnflags", 192);
    brush.__KeyValueFromInt("loadalternativemodels", 0);
    brush.__KeyValueFromInt("skinnumber", 0);
    brush.__KeyValueFromInt("modelindex", 0);
    brush.__KeyValueFromInt("pickupenabled", 1);
    brush.__KeyValueFromInt("Solid", 3);
    brush.__KeyValueFromString("model","models/npcs/turret/turret.mdl")
    ppmod.fire(brush, "enable");
}
createturret(Vector(-1680, -576, -2519))