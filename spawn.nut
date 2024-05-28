IncludeScript("ppmod3.nut");
local area = "lobby"
local catapult = "lower_cat"
local catatarget = "dlc_return_lower_target"
local whichtodo = "catapult"
if (area == "lobby") {
  if (catapult == "lower_cat") {
    if (catatarget == "dlc_return_lower_target") {
      if (whichtodo == "catapult") {
        local blue = ppmod.get("blue")
        local catapult2a1 = ppmod.get("lower_cat")
        catapult2a1.SetOrigin(blue.GetOrigin())
      } else if (whichtodo == "catatarget") {
        local blue = ppmod.get("blue")
        local catapult2a1 = ppmod.get("dlc_return_lower_target")
        catapult2a1.SetOrigin(blue.GetOrigin())
      }
    }
  }
}