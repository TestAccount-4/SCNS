teams <- [
    "Singleplayer",
    "Spectator", // This is not used at all since respawning is broken
    "Red", // P-body
    "Blue" // Atlas
]

CommandList.push(
    class {
        name = "changeteam"
        level = 0

        // !changeteam (optional arg: 0 Singleplayer, 2 P-Body, or 3 Atlas)
        function CC(p, args) {
            if (args.len() == 0) {
                changeteam(p,"")
            }
            args[0] = strip(args[0])
            local IsAdminLevelEnough = function(player) {
                if (GetAdminLevel(player) >= 4) {
                    return true
                }
                return false
            }
            
            local target = FindPlayerByName(args[0])

            local targetOperation = false
            if ((args[0].find("@") != null) && (target == null)) {
                targetOperation = true
            }

            if (targetOperation) {
                if (IsAdminLevelEnough(p) == false) {
                    return SentChatMessage("You do not have permission to do this.")
                }
                try {
                    local args1int = args[1].tointeger()
                } catch (exception) {
                    // SendChatMessage("args[1] does not exist!")
                }
                
                
                // SendChatMessage(args[0])
                // SendChatMessage(args[1])
                // SendChatMessage(typeof args[1])
                switch (args[0]) {
                    case "@a":
                        // for (local player; player = Entities.FindByClassname(player, "player");) {
                        //     try {
                        //         changeteam(player,args1int.tostring()) 
                        //     } catch (exception) {
                        //         changeteam(player,"")
                        //     }
                            
                        // }
                        try {
                            local args1int = args[1].tointeger()
                            SendChatMessage("All player teams are now set to " + teams[args[1].tointeger()] + ".", p)
                            for (local player; player = Entities.FindByClassname(player, "player");) {
                                changeteam(player,args1int.tostring()) 
                            }
                            
                        } catch (exception) {
                            SendChatMessage("Toggled teams of all players.",p)
                            for (local player; player = Entities.FindByClassname(player, "player");) {
                                changeteam(player,"") 
                            }
                        }
                        
                        return

                    case "@b":
                        try {
                            local args1int = args[1].tointeger()
                            SendChatMessage("All Atlas player teams are now set to " + teams[args[1].tointeger()] + ".", p)
                            for (local player; player = Entities.FindByClassname(player, "player");) {
                                if (player.GetTeam() == TEAM_BLUE) {
                                    changeteam(player,args1int.tostring()) 
                                }
                            }
                            
                        } catch (exception) {
                            SendChatMessage("Toggled teams of all Atlas players.",p)
                            for (local player; player = Entities.FindByClassname(player, "player");) {
                                if (player.GetTeam() == TEAM_BLUE) {
                                    changeteam("") 
                                }
                            }
                        }
                        // for (local player; player = Entities.FindByClassname(player, "player");) {
                        //     if (player.GetTeam() == TEAM_BLUE) {
                        //         changeteam(player,args1int.tostring()) 
                        //     }
                        // }
                        // SendChatMessage("All Atlas player teams are now set to " + teams[args[1].tointeger()] + ".", p)
                        return

                    case "@o":
                        try {
                            local args1int = args[1].tointeger()
                            SendChatMessage("All P-Body player teams are now set to " + teams[args[1].tointeger()] + ".", p)
                            for (local player; player = Entities.FindByClassname(player, "player");) {
                                if (player.GetTeam() == TEAM_RED) {
                                    changeteam(player,args1int.tostring()) 
                                }
                            }
                            
                        } catch (exception) {
                            SendChatMessage("Toggled teams of all P-Body players.",p)
                            for (local player; player = Entities.FindByClassname(player, "player");) {
                                if (player.GetTeam() == TEAM_RED) {
                                    changeteam("") 
                                }
                            }
                        }
                        // for (local player; player = Entities.FindByClassname(player, "player");) {
                        //     if (player.GetTeam() == TEAM_RED) {
                        //         changeteam(player,args1int.tostring()) 
                        //     }
                        // }
                        // SendChatMessage("All P-Body player teams are now set to " + teams[args[1].tointeger()] + ".", p)
                        return
                    
                    case "@s":
                        try {
                            local args1int = args[1].tointeger()
                            SendChatMessage("All Singleplayer teams are now set to " + teams[args[1].tointeger()] + ".", p)
                            for (local player; player = Entities.FindByClassname(player, "player");) {
                                if (player.GetTeam() == TEAM_SINGLEPLAYER) {
                                    changeteam(player,args1int.tostring()) 
                                }
                            }
                            
                        } catch (exception) {
                            SendChatMessage("Toggled all Singleplayer teams.",p)
                            for (local player; player = Entities.FindByClassname(player, "player");) {
                                if (player.GetTeam() == TEAM_SINGLEPLAYER) {
                                    changeteam("") 
                                }
                            }
                        }
                        // for (local player; player = Entities.FindByClassname(player, "player");) {
                        //     if (player.GetTeam() == TEAM_SINGLEPLAYER) {
                        //         changeteam(player,args1int.tostring()) 
                        //     }
                        // }
                        // SendChatMessage("All singleplayer teams are now set to " + teams[args[1].tointeger()] + ".", p)
                        return

                    default:
                        SendChatMessage("[ERROR] Invalid target operation used! \"@a\", \"@b\", \"@o\", and \"@s\" are your options!", p)
                        return
                }
            }
            // if (typeof args[0] != "integer") {
            //     SendChatMessage("not an integer")
            // }
            if (target == null || typeof args[0] == "integer" || args[0] == " 1" || args[0] == " 0" || args[0] == " 2" || args[0] == " 3" || args[0] == " -1" || args[0] == "0" || args[0] == "1" || args[0] == "-1" || args[0] == "2" || args[0] == "3") {
                changeteam(p,args[0].tostring())
                // SendChatMessage("Set player team to "+ teams[args.tointeger()] + ".", p)
                return
            } else {
                if (IsAdminLevelEnough(p) == false) {
                    return SentChatMessage("You do not have permission to do this.")
                }
                if (args[1]) {
                    local args1int = args[1].tointeger()
                    // SendChatMessage(args1int.tostring())
                    changeteam(target,args1int.tostring())
                } else {
                    changeteam(target,"")
                }
                
                return
            }
            
        }
    }
)