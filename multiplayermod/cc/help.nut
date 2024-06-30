commandtable <- {}
commandtable["adminmodify"] <- "Prints the admin level of someone or assigns them a new level. \"!adminmodify (target player) (level 1-6)\""
commandtable["changeteam"] <- "Changes your current team. \"!changeteam (optional team arg: 0 Singleplayer, 2 P-Body, 3 Atlas)\""
commandtable["help"] <- "List available commands or print a description of a specific one. \"!help (optional sepecific command)\""
commandtable["hub"] <- "Quick and easy way to return to the cooperative lobby. \"!hub\""
commandtable["kick"] <- "Kicks the player from the server. This will not prevent them from rejoining. \"!kick (target player)\""
commandtable["ban"] <- "Bans the player from the server. This will prevent them from rejoining, permanently. \"!ban (target player)\""
commandtable["kill"] <- "Kill yourself, another player, or a target team. \"!kill (target player/target team/self)\""
commandtable["p2mm"] <- "Sends a message from the server. \"!p2mm (message)\""
commandtable["mpcourse"] <- "Changes the level to the specified cooperative course. \"!mpcourse (course integer 1-6)\""
commandtable["noclip"] <- "Toggles your noclip status. \"!noclip\""
commandtable["playercolor"] <- "Changes player color by color name or RGB value. (ex. !playercolor 0 255 0 or !playercolor red.) Type reset to revert to default color given upon joining."
commandtable["restartlevel"] <- "Reset the current map. \"!restartlevel\""
commandtable["rocket"] <- "Send yourself, another player, or a target team into the air for them to blow up. \"!rocket (target arg: Specific player, team target. Self if no arg.)\""
commandtable["slap"] <- "Slap yourself, another player, or a target team dealing a tiny amount of damage and jolting. \"!slap (target arg: Specific player, team target. Self if no arg.)\""
commandtable["spchapter"] <- "Changes the level to the specified singleplayer chapter. \"!spchapter (chapter integer 1-9)\""
commandtable["speed"] <- "Changes your player speed. \"!speed (float arg)\""
commandtable["teleport"] <- "Teleport yourself, another player, or a target team to a destination. \"!teleport (target arg: Specific player, team target. destination player if only this arg.) (destination arg: player)\""
commandtable["vote"] <- "Invoke this to get a headcount on whether something should happen or not. \"!vote (vote choice arg: changelevel, kick, or hostgunonly) (arg for changelevel map name or kick player name)\""

CommandList.push(
    class {
        name = "help"
        level = 0

        // !help (optional arg: command name)
        function CC(p, args) {
            try {
                args[0] = strip(args[0])
                if (commandtable.rawin(args[0])) {
                    SendChatMessage("[HELP] " + args[0] + ": " + commandtable[args[0]], p)
                }
                else {
                    SendChatMessage("[HELP] Unknown chat command: " + args[0], p)
                }
            } catch (exception) {
                SendChatMessage("[HELP] Target team operations:", p)
                SendChatMessage("[HELP] \"@a\": Everyone | \"@b\": Atlas Team", p)
                SendChatMessage("[HELP] \"@o\": P-Body Team | \"@s\": SP Team", p)
                SendChatMessage("[HELP] Available commands:", p)
                local availablecommands = ""
                foreach (command in CommandList) {
                    if (command.level <= GetAdminLevel(p)) {
                        // 150 characters max allowed in chat box per message
                        if ((availablecommands + command.name + ", ").len() >= 150) {
                            // Print it out
                            SendChatMessage("[HELP] " + availablecommands.slice(0, availablecommands.len() - 2), p) // Remove excess comma and space
                            availablecommands = ""
                        }
                        availablecommands = availablecommands + command.name + ", "
                    }
                }
                SendChatMessage("[HELP] " + availablecommands.slice(0, availablecommands.len() - 2), p) // Remove excess comma and space
                // SendChatMessage("[HELP] This command can also print a description for another if supplied with it.", p) // bloated the chat
            }
        }
    }
)