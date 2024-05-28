local red = Entities.FindByName(null, "red");
function MinifyModel(mdl) {
// Add the models/ to the side of the model name if it's not already there
    if (mdl.slice(0, 7) == "models/") {
        mdl = mdl.slice(7, mdl.len())
    }
    // Add the .mdl to the end of the model name if it's not already there
    if (mdl.slice(mdl.len() - 4, mdl.len()) == ".mdl") {
        mdl = mdl.slice(0, mdl.len() - 4)
    }
    return mdl
}
function PrecacheModelNoDelay(mdl) {
        // Add the models/ to the side of the model name if it's not already there
    if (mdl.slice(0, 7) != "models/") {
        mdl = "models/" + mdl
    }
    // Add the .mdl to the end of the model name if it's not already there
    if (mdl.slice(mdl.len() - 4, mdl.len()) != ".mdl") {
        mdl = mdl + ".mdl"
    }

    // Remove the models/ from the left side and the .mdl from the right side
    local minimdl = MinifyModel(mdl)

    // Check if the model is already precached
    local NotPrecached = true
    foreach (precached in PrecachedProps) {
        if (precached == minimdl) {
            NotPrecached = false
        }
    }

    if (!Entities.FindByModel(null, mdl) && NotPrecached) {
        PrecachedProps.push(minimdl)
        if (!CheatsOn) {
            SendToConsoleP2MM("sv_cheats 1; prop_dynamic_create " + minimdl)
        } else {
            SendToConsoleP2MM("sv_cheats 1; prop_dynamic_create " + minimdl)
        }
        if (!CheatsOn) {
            SendToConsoleP2MM("sv_cheats 0")
        }
        EntFire("p2mm_servercommand", "command", "script Entities.FindByModel(null, \"" + mdl + "\").Destroy()", 0.4) // FIXME!! Causes errors in vscript
        if (GetDeveloperLevel()) {
            printl("(P2:MM): Precached model: " + minimdl + " AKA " + mdl)
        }
    } else {
        if (GetDeveloperLevel()) {
            printl("(P2:MM): Model: " + mdl + " already precached!")
        }
    }
}
PrecacheModelNoDelay("player\ballbot\ballbot_opt.mdl")