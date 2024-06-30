//  ██████╗██████╗             █████╗   ██╗██╗           ████████╗██████╗             ██╗       ██╗ █████╗ ██╗     ██╗                ██████╗ ██╗   ██╗████████╗████████╗ █████╗ ███╗  ██╗
// ██╔════╝██╔══██╗           ██╔══██╗ ██╔╝██║           ╚══██╔══╝██╔══██╗            ██║  ██╗  ██║██╔══██╗██║     ██║                ██╔══██╗██║   ██║╚══██╔══╝╚══██╔══╝██╔══██╗████╗ ██║
// ╚█████╗ ██████╔╝           ███████║██╔╝ ██║              ██║   ██████╦╝            ╚██╗████╗██╔╝███████║██║     ██║                ██████╦╝██║   ██║   ██║      ██║   ██║  ██║██╔██╗██║
//  ╚═══██╗██╔═══╝            ██╔══██║███████║              ██║   ██╔══██╗             ████╔═████║ ██╔══██║██║     ██║                ██╔══██╗██║   ██║   ██║      ██║   ██║  ██║██║╚████║
// ██████╔╝██║     ██████████╗██║  ██║╚════██║██████████╗   ██║   ██████╦╝██████████╗  ╚██╔╝ ╚██╔╝ ██║  ██║███████╗███████╗██████████╗██████╦╝╚██████╔╝   ██║      ██║   ╚█████╔╝██║ ╚███║
// ╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝     ╚═╝╚═════════╝   ╚═╝   ╚═════╝ ╚═════════╝   ╚═╝   ╚═╝  ╚═╝  ╚═╝╚══════╝╚══════╝╚═════════╝╚═════╝  ╚═════╝    ╚═╝      ╚═╝    ╚════╝ ╚═╝  ╚══╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        GlobalSpawnClass.m_bUseAutoSpawn <- true
        PermaPotato = true
        // Make elevator start moving on level load
        EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "StartForward", "", 0, null, null)
        // Destroy objects
        Entities.FindByName(null, "door_0-close_door_rl").Destroy()
        Entities.FindByName(null, "fall_fade").Destroy()
        Entities.FindByClassnameNearest("trigger_multiple", Vector(736, 960, 160), 20).Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(864, 960, 168), 20).Destroy()

        // Make changing levels work
        EntFire("transition_trigger", "AddOutput", "OnStartTouch p2mm_servercommand:Command:changelevel sp_a4_tb_polarity:0.3", 0, null)
    }

    if (MSPostPlayerSpawn) {
        NewApertureStartElevatorFixes()
    }
}