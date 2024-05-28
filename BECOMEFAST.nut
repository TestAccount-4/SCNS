playerspeedmod <- Entities.CreateByClassname("player_speedmod");
playerspeedmod.__KeyValueFromString("targetname", "p2mm_player_speedmod");
function SetSpeed(player, speed) {
    EntFireByHandle(Entities.FindByName(null, "p2mm_player_speedmod"), "modifyspeed", speed.tostring(), 0, player, player)
};
SetSpeed("blue","5");