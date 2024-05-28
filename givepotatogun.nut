IncludeScript("ppmod3.nut");
function PotatoIfy(plr) {
    if (Entities.FindByName(null, "weapon_portalgun_player" + GetBluePlayerIndex())) {
        EntFire("weapon_portalgun_player" + GetBluePlayerIndex(), "SetBodygroup", "1", 0)
    }
    if (Entities.FindByName(null, "viewmodel_player" + plr.entindex())) {
        EntFire("viewmodel_player" + GetBluePlayerIndex(), "SetBodyGroup", "1", 0)
    }
}
local blue = ppmod.get("blue");
local host = FindByEntIndex(1)
PotatoIfy(host)
// EntFire("!picker","addoutput","OnPressed !activator:ignitelifetime:99999999:0:-1")
// EntFire("!picker","addoutput","OnPressed !activator:ignitelifetime:0:0:-1")