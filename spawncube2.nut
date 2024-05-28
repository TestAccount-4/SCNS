IncludeScript("pcapture-lib") 

// Find a weighted cube entity
local cargo = entLib.FindByClassname("prop_weighted_cube")

// Get weighted cube position
local cargopos = cargo.GetOrigin()
local cargoposY = cargopos.y += 100
local cargorananglepitch = RandomInt(-180,180)
local cargoranangleyaw = RandomInt(-180,180)
local cargoranangleroll = RandomInt(-180,180)

// Error if no cube found
if(cargo == null)
    return dev.error("There is not a single prop_weighted_cube on the map")

// Set render mode to transparent 
cargo.SetKeyValue("rendermode", 5)

// Fade opacity from 255 to 125 over 1 second
animate.AlphaTransition(cargo, 255, 125, 1)
animate.AnglesTransitionByTime(cargo, cargo.GetAngles(), Vector(cargorananglepitch,cargoranangleroll,cargoranangleyaw), 1, {globalDelay = 0})

// Transition color from white to orange over 1 second after 0.5 second delay 
animate.ColorTransition(cargo, "255 255 255", "255 125 0", 1, {globalDelay = 0.5})

// Move cube to Vector(0, 0, 0) at a speed of 1 unit/s after 1 second delay

// Transition color back to white over 1.5 seconds after 1.5 second delay
// Cancel "cargo_move" event on completion 
animate.ColorTransition(cargo, "255 125 0", "255 255 255", 1.5, {globalDelay = 1.5, outputs = function() {
        
    }
})
animate.AlphaTransition(cargo, 125, 255, 1,{globalDelay = 1.5});


// Additional commands to configure the environment
EntFireByHandle(self, "runscriptcode", "SendToConsole(\"developer 2\")", 1, null, null)