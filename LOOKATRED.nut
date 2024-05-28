// First, find the entities by their target names
local blue = Entities.FindByName(null, "blue");
local red = Entities.FindByName(null, "red");

function TraceFromEntityViewpoint(entityName) {
    local entity = Entities.FindByName(null, entityName);
    if (!entity) {
        print("Entity named " + entityName + " not found.");
        return null;
    }

    // Assuming we can get the eye position and eye direction (forward vector)
    local eyePos = entity.EyePosition();
    local eyeDir = entity.EyeAngles().Forward();
    
    // Calculate a far point in the direction the entity is looking
    local traceEnd = eyePos + (eyeDir * 1024); // 1024 units forward

    // Perform the trace
    local trace = UTIL_TraceLine(eyePos, traceEnd, MASK_SOLID, entity, COLLISION_GROUP_NONE);

    if (trace.DidHit()) {
        local hitEntity = trace.m_pEnt;
        print("Entity " + entityName + " is looking at: " + hitEntity.GetClassname());
        return hitEntity;
    } else {
        print(entityName + " is not looking at any entity.");
        return null;
    }
}

// Function to turn an entity to face towards another entity
function TurnEntityToFaceAnother(target, toFace) {
    if (target == null || toFace == null) {
        print("One of the entities is not found.");
        return;
    }

    // Calculate the direction vector from target to toFace
    local direction = toFace.GetOrigin() - target.GetOrigin();
    local angles = VecToAngles(direction); // Assuming a VecToAngles function exists

    // Now, set the target entity's angles to face the 'toFace' entity.
    // This is highly dependent on your game's scripting capabilities.
    // For illustrative purposes, let's assume there's a function to set angles.
    target.SetAngles(angles);
}

// Assuming 'blue' is currently looking at another entity, let's find that entity
// This would involve a trace line or similar, depending on your game's scripting engine
local lookedAtEntity = TraceFromEntityViewpoint("blue") // Placeholder, you'd replace this with actual logic to find what blue is looking at

// Now, turn the lookedAtEntity to face 'red'
TurnEntityToFaceAnother(lookedAtEntity, red);
