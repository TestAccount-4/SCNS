IncludeScript("ppmod3.nut");
local p2mm_servercommand = ppmod.get("p2mm_servercommand");
if (p2mm_servercommand == null|| !p2mm_servercommand) {
    Entities.CreateByClassname("point_servercommand").__KeyValueFromString("targetname", "p2mm_servercommand")
}

function SendChatMessage(message, pActivatorAndCaller = null) {
    // We try to use server command since that allows the host
    // to send instant messages without any chat refresh delay
    local pEntity = Entities.FindByName(null, "p2mm_servercommand")
    if (pActivatorAndCaller != null && pActivatorAndCaller != Entities.FindByClassname(null, "player")) {
        // Send messages from a specific client
        pEntity = p2mm_clientcommand
    }
    EntFireByHandle(pEntity, "command", "say " + message, 0, pActivatorAndCaller, pActivatorAndCaller)
}
SendChatMessage("test");