IncludeScript("ppmod3.nut");
local blue = ppmod.get("blue")
local e = Entities.CreateByClassname("npc_maker");
e.__KeyValueFromString("NPCType","prop_weighted_cube");
e.__KeyValueFromString("targetname","23842735923572395237592357");
e.__KeyValueFromString("StartDisabled","0")
e.__KeyValueFromString("MaxNPCCount","99999")
e.__KeyValueFromString("spawnflags","32")

e.SetOrigin(blue.GetOrigin())
e.SetAngles(blue.)
EntFire("23842735923572395237592357","spawn");
