local blue = ppmod.get("blue")
local red = ppmod.get("red")
local host = FindByEntIndex(1)
local partner = FindByEntIndex(2)
if (NoclipState == false) {
	if (host.IsNoclipping() == false) {
		ppmod.fire(host, "addoutput", "MoveType 8")
	} else if (host.IsNoclipping() == true) {
		ppmod.fire(host, "addoutput", "MoveType 2")
	}
} else {
	if (partner.IsNoclipping() == false) {
		ppmod.fire(partner, "addoutput", "MoveType 8")
	} else if (partner.IsNoclipping() == true) {
		ppmod.fire(partner, "addoutput", "MoveType 2")
	}
}

