IncludeScript("ppmod3.nut");
function brush(pos, size, type = "func_brush", ang = Vector()) {
    // local brush = type;
    local brush = Entities.CreateByClassname(type);
    brush.SetOrigin(pos);
    brush.SetAngles(ang.x, ang.y, ang.z);
    brush.__KeyValueFromInt("Solid", 3);
    return brush;
}
local ent = null;     //The variable name "ent" is arbitrary.
while(ent = Entities.FindByClassname(ent, "trigger_hurt"))     //Indeed, we mean '=' and not '==' ! The loop aborts if "ent" becomes null.
{
    local ento = ent.GetOrigin()
    local ENTY = ento.y += 16
  catapult <- brush(Vector(ento.x,ENTY,ento.z), Vector(1,1,1),"trigger_multiple");
  catapult.__KeyValueFromInt("CollisionGroup", 1);
  EntFireByHandle(catapult, "Enable", "", 0, null, null);
  catapult.__KeyValueFromString("alternateticksfix","0");
  catapult.__KeyValueFromString("spawnflags","4105");
  catapult.__KeyValueFromString("StartDisabled","0");
  // catapult.__KeyValueFromString("targetname",ent.GetName());
  ppmod.addscript(catapult,"OnStartTouch",function(activator,caller) {
    activator.SetVelocity(Vector(0,0,1300))
  },0.0,-1,true)
  catapult.SetSize(ent.GetBoundingMins(),ent.GetBoundingMaxs())
  ppmod.fire(ent,"disable")
}