IncludeScript("ppmod3.nut");
local blue = ppmod.get("blue")
local red = ppmod.get("red")
function brush(pos, size, type = "func_brush", ang = Vector()) {
    local brush = type;
    if(typeof type == "string") brush = Entities.CreateByClassname(type);
    brush.SetOrigin(pos);
    brush.SetAngles(ang.x, ang.y, ang.z);
    brush.SetSize(Vector() - size, size);
    brush.__KeyValueFromInt("Solid", 3);
    return brush;
}

catapult <- brush(red.GetOrigin(), Vector(8, 8, 8), "trigger_catapult");
  catapult.__KeyValueFromInt("CollisionGroup", 1);
  EntFireByHandle(catapult, "Enable", "", 0, null, null);

// Set the keyvalues based on the attributes from the image
catapult.__KeyValueFromString("DirectionSuppressAirControl", "0");
catapult.__KeyValueFromString("AirCtrlSupressionTime", "1");
catapult.__KeyValueFromString("AngularImpulse", "1");
catapult.__KeyValueFromString("applyAngularImpulse", "1");
catapult.__KeyValueFromString("useThresholdCheck", "0");
catapult.__KeyValueFromString("entryAngleTolerance", "0.0");
catapult.__KeyValueFromString("useExactVelocity", "0");
catapult.__KeyValueFromString("useExactVerticalVelocity", "0");
catapult.__KeyValueFromString("exactVelocityChoiceType", "0");
catapult.__KeyValueFromString("upperThreshold", "0.30");
catapult.__KeyValueFromString("targetname", "lower_cat2");
catapult.__KeyValueFromString("launchTarget", "blue"); //Target
catapult.__KeyValueFromString("lowerThreshold", "0.15");
catapult.__KeyValueFromString("onlyVelocityCheck", "0");
catapult.__KeyValueFromString("physicsSpeed", "450");
catapult.__KeyValueFromString("playerSpeed", "450");
catapult.__KeyValueFromString("spawnflags", "4097");
catapult.__KeyValueFromString("StartDisabled", "0");

catapult2 <- brush(blue.GetOrigin(), Vector(8, 8, 8), "trigger_catapult");
  catapult2.__KeyValueFromInt("CollisionGroup", 1);
  EntFireByHandle(catapult2, "Enable", "", 0, null, null);

// Set the keyvalues based on the attributes from the image
catapult2.__KeyValueFromString("DirectionSuppressAirControl", "0");
catapult2.__KeyValueFromString("AirCtrlSupressionTime", "1");
catapult2.__KeyValueFromString("AngularImpulse", "1");
catapult2.__KeyValueFromString("applyAngularImpulse", "1");
catapult2.__KeyValueFromString("useThresholdCheck", "0");
catapult2.__KeyValueFromString("entryAngleTolerance", "0.0");
catapult2.__KeyValueFromString("useExactVelocity", "0");
catapult2.__KeyValueFromString("useExactVerticalVelocity", "0");
catapult2.__KeyValueFromString("exactVelocityChoiceType", "0");
catapult2.__KeyValueFromString("upperThreshold", "0.30");
catapult2.__KeyValueFromString("targetname", "lower_cat3");
catapult2.__KeyValueFromString("launchTarget", "red"); //Target
catapult2.__KeyValueFromString("lowerThreshold", "0.15");
catapult2.__KeyValueFromString("onlyVelocityCheck", "0");
catapult2.__KeyValueFromString("physicsSpeed", "450");
catapult2.__KeyValueFromString("playerSpeed", "450");
catapult2.__KeyValueFromString("spawnflags", "4097");
catapult2.__KeyValueFromString("StartDisabled", "0");
