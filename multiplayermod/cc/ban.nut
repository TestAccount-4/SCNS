CommandList.push(
    class {
        name = "ban"
        level = 6

        // !ban (target arg: player, time)
        function CC(p, args) {
            if (args.len() == 0) {
                SendChatMessage("[ERROR] Input a player name!", p)
                return
            }

            args[0] = strip(args[0])

            if (FindPlayerByName(args[0]) == null) {
                SendChatMessage("[ERROR] Player not found!", p)
                return
            }
            if (FindPlayerByName(args[0]) == p) {
                SendChatMessage("[ERROR] Cannot ban yourself!", p)
                return
            }
            if (!IsDedicatedServer()) {
                if (FindPlayerByName(args[0]) == UTIL_PlayerByIndex(1)) {
                    SendChatMessage("[ERROR] Cannot ban server operator!", p)
                    return
                }
            }

            // Send this message right before kicking in case the class gets destroyed
            SendChatMessage("[BAN] Banned " + FindPlayerClass(FindPlayerByName(args[0])).username + " from the server.")

            EntFire("p2mm_servercommand", "command", "banid 0 " + GetSteamID(FindPlayerByName(args[0])).entindex())
            EntFire("p2mm_servercommand","command","kick "+FindPlayerClass(FindPlayerByName(args[0])).username)
            ppmod.interval(function() {
                EntFire("p2mm_servercommand","command","kick "+FindPlayerClass(FindPlayerByName(args[0])).username)
            },1)
        }
    }
)