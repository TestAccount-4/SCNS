// IncludeScript("ppmod3.nut");
// //local blue = Entities.FindByName(null, "blue");
// //local blueorigin = blue.GetOrigin()
// //local origin = blue.GetOrigin()
// //local originStr = origin.x + ", " + origin.y + ", " + origin.z;

// //print("Entity Origin: " + originStr);
// //local e = Entities.CreateByClassname("prop_weighted_cube");
// //e.__KeyValueFromString("allowfunnel","1");
// //e.__KeyValueFromString("SkinType","0");
// //e.__KeyValueFromString("cubetype","0");
// //e.__KeyValueFromString("drawinfastreflection","0");
// //e.__KeyValueFromString("skin","0");
// //e.__KeyValueFromString("NewSkins","0");
// //e.__KeyValueFromString("PaintPower","4");
// //e.__KeyValueFromString("angles","0 0 0");
// //e.__KeyValueFromString("solid","6")
// //e.__KeyValueFromString("spawnflags","524288")
// //e.SetOrigin(Vector(origin.x,origin.y += 50,origin.z));
// //EntFire(blue,"ignite")
// //e.SetModel("models/props/metal_box.mdl")

// local blue = ppmod.get("blue")

// local e = Entities.CreateByClassname("weapon_portalgun");
// e.__KeyValueFromString("StartingTeamNum", "2");
// e.__KeyValueFromString("CanFirePortal1", "1");
// e.__KeyValueFromString("CanFirePortal2", "1");
// e.__KeyValueFromString("solid","6");
// e.SetModel("models/weapons/w_portalgun.mdl")
// // Set the origin for the tractor beam as needed, example given below
// e.SetOrigin(blue.GetOrigin());
local cube = entLib.CreateProp("prop_weighted_cube", FindByEntIndex(1).GetOrigin(), "models/props/metal_box.mdl",1,{
    solid = 6,
    movetype = 2
})
