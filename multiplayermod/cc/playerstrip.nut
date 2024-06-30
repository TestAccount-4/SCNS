CommandList.push(
    class {
        name = "playerstrip"
        level = 5

        // !playerstrip (target arg: player)
        function CC(p, args) {

            // if (args.len() == 0) {
            //     SendChatMessage("[ERROR] Input a player name!", p)
            //     return
            // }

            args[0] = strip(args[0])
            // ppmod.fire(FindPlayerByName(args[0]).entindex())

            // if (FindPlayerByName(args[0]) == null) {
            //     SendChatMessage("[ERROR] Player not found!", p)
            //     return
            // }
            // if (!IsDedicatedServer()) {
            //     if (FindPlayerByName(args[0]) == UTIL_PlayerByIndex(1)) {
            //         SendChatMessage("[ERROR] Cannot kick server operator!", p)
            //         return
            //     }
            // }

            if (args.len() == 0) {
                PlayerStrip(p)
            }
            
            local target = FindPlayerByName(args[0])

            local targetOperation = false
            if ((args[0].find("@") != null) && (target == null)) {
                targetOperation = true
            }

            if (targetOperation) {
                switch (args[0]) {
                    case "@a":
                        for (local player; player = Entities.FindByClassname(player, "player");) {
                            PlayerStrip(player) 
                        }
                        SendChatMessage("Removed all player's weapons.", p)
                        return

                    case "@b":
                        for (local player; player = Entities.FindByClassname(player, "player");) {
                            if (player.GetTeam() == TEAM_BLUE) {
                                PlayerStrip(player)
                            }
                        }
                        SendChatMessage("Removed all Atlas player's weapons.", p)
                        return

                    case "@o":
                        for (local player; player = Entities.FindByClassname(player, "player");) {
                            if (player.GetTeam() == TEAM_RED) {
                                PlayerStrip(player)
                            }
                        }
                        SendChatMessage("Removed all P-Body player's weapons.", p)
                        return
                    
                    case "@s":
                        for (local player; player = Entities.FindByClassname(player, "player");) {
                            if (player.GetTeam() == TEAM_SINGLEPLAYER) {
                                PlayerStrip(player)
                            }
                        }
                        SendChatMessage("Removed all Singleplayer team player's weapons.", p)
                        return

                    default:
                        SendChatMessage("[ERROR] Invalid target operation used! \"@a\", \"@b\", \"@o\", and \"@s\" are your options!", p)
                        return
                }
            }
            
            if (target == null) {
                SendChatMessage("[ERROR] Player not found!", p)
                return
            } else {
                PlayerStrip(args[0])
                SendChatMessage("Removed weapons from " + FindPlayerClass(FindPlayerByName(args[0])).username + ".", p)
            }

            // // Players can still join the game again if you use this
            // EntFire("p2mm_servercommand", "command", "kick " + FindPlayerClass(FindPlayerByName(args[0])).username)
        }
    }
)