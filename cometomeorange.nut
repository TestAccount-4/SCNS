IncludeScript("ppmod3.nut");
local blue = ppmod.get("blue")
local glados = ppmod.get("@glados")
local red = ppmod.get("red")
//local catapult2a1 = ppmod.get("dlc_return_lower_target")
//catapult2a1.SetOrigin(blue.GetOrigin())
//local red = ppmod.get("red")
//local catapult2a1 = ppmod.get("lower_cat")
//catapult2a1.SetOrigin(red.GetOrigin())



//red.SetOrigin(blue.GetOrigin())
//local foundentity = FindByNameNearest("*", blue.EyePosition(), 1)
//foundentity.SetOrigin(blue.GetOrigin())
//function rotate() {
//local ent = Entities.First(); // Get the first entity
//while (ent != null) // Continue until there are no more entities
//{
  //  local angles = ent.GetAngles(); // Get the current angles of the entity as a Vector
  //  local anglesb = angles.z += 45; // Add 45 degrees to the roll (z-axis)
   // ent.SetAngles(angles.x,angles.y,anglesb); // Set the new angles to the entity with a single Vector argument
 //   ent = Entities.Next(ent); // Proceed to the next entity
//}
//}
ppmod.interval(function() {
       local ent = Entities.First(); // Get the first entity
    while (ent != null) // Continue until there are no more entities
{
        if (ent.GetName() == "red") {
                ent = Entities.Next(ent); // Proceed to the next entity
        } else if (ent.GetName() == "blue"){
                ent = Entities.Next(ent); // Proceed to the next entity
        }
    local angles = ent.GetAngles(); // Get the current angles of the entity as a Vector
    local anglesz = angles.z += RandomInt(-1, 1); // Add 45 degrees to the roll (z-axis)
    local anglesy = angles.y += RandomInt(-1, 1); // Add 45 degrees to the roll (z-axis)
    local anglesx = angles.x += RandomInt(-1, 1); // Add 45 degrees to the roll (z-axis)
    ent.SetAngles(anglesx,anglesy,anglesz); // Set the new angles to the entity with a single Vector argument
    ent = Entities.Next(ent); // Proceed to the next entity
}    
})

//local ent = Entities.First(); // Get the first entity
//while (ent != null) // Continue until there are no more entities
//{
//    local angles = ent.GetAngles(); // Get the current angles of the entity as a Vector
//    local anglesb = angles.z += 45; // Add 45 degrees to the roll (z-axis)
//    ent.SetAngles(angles.x,angles.y,anglesb); // Set the new angles to the entity with a single Vector argument
//    ent = Entities.Next(ent); // Proceed to the next entity
//}