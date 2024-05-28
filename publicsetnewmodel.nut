function main() {
    local a1 = "models/player/bot_assembly/assembly_station.mdl";
    local b1 = 1;
	local a2 = "blue";
	local b2 = "red";
    j1(a1, b1, a2, b2);
}

function c1(d, e, model) {
    local f = null;     
    while(f = Entities.FindByName(f, d)) {
        f.SetModel(model);
    }
}

function g1(d, model) {
    local f = null;
    while(f = Entities.FindByClassname(f, d)) {
        f.SetModel(model);
    }
}

function h1(i, j, k, model) {
    if (k == 1) {
        c1(i, j, model);
    } else {
        g1(i, model);
    }
}

function j1(a3, b3, a4, b4) {
print("EPLASES HELP ME")
    switch(b3) {
        case 1:
            h1(a4, "", 1, a3);
            break;
			EntFire("blue","skin","1")
        case 2:
            h1(b4, "", 1, a3);
			EntFire("red","skin","1")
            break;
        case 3:
            h1("prop_weighted_cube", "", 2, a3);
            break;
        default:
    }
}

main();
