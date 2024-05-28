function TeleportToSpawnPoint(p, SpawnClass) {
    if (SpawnClass == null) {
        SpawnClass = BestGuessSpawnpoint()
    }

    if (p.GetTeam() == 3) {
        // Blue team
        p.SetOrigin(SpawnClass.blue.spawnpoint)
        p.SetAngles(SpawnClass.blue.rotation.x, SpawnClass.blue.rotation.y, SpawnClass.blue.rotation.z)
        p.SetVelocity(SpawnClass.blue.velocity)
    }
    else if (p.GetTeam() == 2) {
        // Red team
        p.SetOrigin(SpawnClass.red.spawnpoint)
        p.SetAngles(SpawnClass.red.rotation.x, SpawnClass.red.rotation.y, SpawnClass.red.rotation.z)
        p.SetVelocity(SpawnClass.red.velocity)
    }
    // If someone respawns after dying on the singleplayer team, they will automatically
    // be switched to the native team that they joined the server with
}
local blue = Entities.FindByName("blue");
local red = Entities.FindByName("red");
TeleportToSpawnPoint(blue,null);
TeleportToSpawnPoint(red,null);