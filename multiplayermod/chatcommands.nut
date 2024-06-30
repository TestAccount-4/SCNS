//---------------------------------------------------
//         *****!Do not edit this file!*****
//---------------------------------------------------
// Purpose: Enable commands through the chat box.
//---------------------------------------------------

// TODO: 
// - Fix how we work out arguments for players with spaces in their names
// - Fix adminmodify pushing players instead of changing existing slot

if (Config_UseChatCommands) {
    // This can only be enabled when the plugin is loaded fully
    if (!PluginLoaded) {
        if (GetDeveloperLevelP2MM()) {
            printlP2MM("Can't add chat commands since no plugin is loaded!")
        }
        return
    }
} else {
    printlP2MM("Config_UseChatCommands is false. Not adding chat callback for chat commands!")
    return
}

// The whole filtering process for the chat commands
function ChatCommands(iUserIndex, rawText) {
    local Message = strip(RemoveDangerousChars(rawText))

    local pPlayer = UTIL_PlayerByIndex(iUserIndex)
    if ((pPlayer == null)) { return } // Invalid player or dedicated server console

    local AdminLevel = GetAdminLevel(pPlayer)

    //--------------------------------------------------

    // Be able to tell what is and isn't a chat command
    if (Message.slice(0, 1) != "!" || Message.len() < 2) {
        return
    }
    if (Message.slice(0, 2) == "!!" || Message.slice(0, 2) == "! ") {
        return
    }
    if (Message.len() > 3) {
        if (Message.slice(0, 4) == "!SAR") {
            return // speedrun plugin events can interfere
        }
    }

    // The real chat command doesn't have the "!". Also split arguments
    local szTargetCommand = strip(Replace(Message, "!", ""))

    local Args = SplitBetween(szTargetCommand, " ", true)
    if (Args.len() > 0) {
        Args.remove(0)
    }

    foreach (cmd in CommandList) {
        if (StartsWith(szTargetCommand.tolower(), cmd.name)) {
            szTargetCommand = cmd
            break
        }
    }

    //--------------------------------------------------
    
    // Confirmed that it's a command that follows our syntax, now try to run it

    // Does the exact command exist?
    if (typeof szTargetCommand != "class") {
        SendChatMessage("[ERROR] Command not found. Use !help to list some commands!", pPlayer)
        return
    }

    // Do we have the correct admin level for this command?
    if (!(szTargetCommand.level <= AdminLevel)) {
        SendChatMessage("[ERROR] You do not have permission to use this command!", pPlayer)
        return
    }

    RunChatCommand(szTargetCommand, Args, pPlayer)
}

//=======================================
// Import chat command content
//=======================================

CommandList <- []

local IncludeScriptCC = function(script) {
    try {
        IncludeScript("multiplayermod/cc/" + script + ".nut")
    } catch (exception) {
        p2mmlP2MM("Failed to load: multiplayermod/cc/" + script + ".nut")
    }
}

// Include the scripts that will push each
// chat command to the CommandList array

// The order of the CC list will be dependent on what is included first
// Organized alphabetically...

IncludeScriptCC("adminmodify")
IncludeScriptCC("ban")
IncludeScriptCC("changeteam")
IncludeScriptCC("help")
IncludeScriptCC("hub")
IncludeScriptCC("kick")
IncludeScriptCC("kill")
IncludeScriptCC("mpcourse")
IncludeScriptCC("noclip")
IncludeScriptCC("playercolor")
IncludeScriptCC("restartlevel")
IncludeScriptCC("rocket")
IncludeScriptCC("slap")
IncludeScriptCC("spchapter")
IncludeScriptCC("speed")
IncludeScriptCC("teleport")
IncludeScriptCC("vote")
IncludeScriptCC("p2mm")
IncludeScriptCC("playerstrip")

//--------------------------------------
// Chat command function dependencies
//
// Note: These aren't in functions.nut
// since there's no need to define them
// if the player chooses not to use CC
//--------------------------------------

function SendChatMessage(message, pActivatorAndCaller = null) {
    if (SendToChatLoaded) {
        local color = "\x03" // light green; default, private message
        if (pActivatorAndCaller == null) {
            pActivatorAndCaller = 0 // 0 means sending to everyone via plugin logic
            color = "\x04" // Bright green; public message
        } else {
            pActivatorAndCaller = pActivatorAndCaller.entindex()
        }

        if (color == "\x03") {
            printl("(P2:MM): " + message) // Always log private messages to server console
        }
        else if (color == "\x04" && IsDedicatedServer()) {
            printl("(P2:MM): " + message) // public messages dont print to console on dedicated, since we are not a player here
        }

        SendToChat(color + "(P2:MM): " + message, pActivatorAndCaller)
    } else {
        // Try to use server command in the case of dedicated servers
        local pEntity = Entities.FindByName(null, "p2mm_servercommand")
        if (pActivatorAndCaller != null) {
            // Send messages from a specific client
            pEntity = p2mm_clientcommand
        }
        EntFireByHandle(pEntity, "command", "say " + message, 0, pActivatorAndCaller, pActivatorAndCaller)
    }
    // Note that "\x05" is used for private messages with more than one person
    // You will need to create a special case to use it (see cc/teleport.nut for an example)
}

function RunChatCommand(cmd, args, plr) {
    if (GetDeveloperLevelP2MM()) {
        printlP2MM("Running chat command \"" + cmd.name + "\" from player \"" + FindPlayerClass(plr).username + "\"")
    }
    cmd.CC(plr, args)
}

function UTIL_PlayerByIndex(index) {
    for (local player; player = Entities.FindByClassname(player, "player");) {
        if (player.entindex() == index) {
            return player
        }
    }
    return null
}

function RemoveDangerousChars(str) {
    str = Replace(str, "%n", "") // Can cause crashes!
    if (StartsWith(str, "^")) { // ?
        return ""
    }
    return str
}

function StrToList(str) {
    local list = []
    local i = 0
    while (i < Len(str)) {
        list.push( Slice(str, i, i + 1) )
        i = i + 1
    }
    return list
}

// preserve = true : means that the symbol at the beginning of the string will be included in the first part
function SplitBetween(str, keysymbols, preserve = false) {
    local keys = StrToList(keysymbols)
    local lst = StrToList(str)

    local contin = false
    foreach (key in keys) {
        if (Contains(str, key)) {
            contin = true
            break
        }
    }

    if (!contin) {
        return []
    }


    // FOUND SOMETHING

    local split = []
    local curslice = ""

    foreach (indx, letter in lst) {
        local contains = false
        foreach (key in keys) {
            if (letter == key) {
                contains = key
                if (indx == 0 && preserve) {
                    curslice = curslice + letter
                }
            }
        }

        if (contains != false) {
            if (Len(curslice) > 0 && indx > 0) {
                split.push(curslice)
                if (preserve) {
                    curslice = contains
                } else {
                    curslice = ""
                }
            }
        } else {
            curslice = curslice + letter
        }
    }

    if (Len(curslice) > 0) {
        split.push(curslice)
    }

    return split
}

function FindPlayerByName(name) {
    name = name.tolower()
    local best = null
    local bestnamelen = 99999
    local bestfullname = ""

    for (local p = null; p = Entities.FindByClassname(p, "player");) {
        local username = FindPlayerClass(p).username
        username = username.tolower()

        if (username == name) {
            return p
        }

        if (Len(Replace(username, name, "")) < Len(username) && Len(Replace(username, name, "")) < bestnamelen) {
            best = p
            bestnamelen = Len(Replace(username, name, ""))
            bestfullname = username
        } else if (Len(Replace(username, name, "")) < Len(username) && Len(Replace(username, name, "")) == bestnamelen) {
            if (Find(username, name) < Find(bestfullname, name)) {
                best = p
                bestnamelen = Len(Replace(username, name, ""))
                bestfullname = username
            }
        }
    }
    return best
}

function GetAdminLevel(plr) {
    foreach (admin in Admins) {
        // Separate the SteamID and the admin level
        local level = split(admin, "[]")[0]
        local SteamID = split(admin, "]")[1]

        if (SteamID == FindPlayerClass(plr).steamid.tostring()) {
            if (SteamID == GetSteamID(1).tostring()) {
                // Host always has max perms even if defined lower
                if (level.tointeger() < 6) {
                    return 6
                }
                // In case we add more admin levels, return values defined higher than 6
                return level.tointeger()
            } else {
                // Use defined value for others
                return level.tointeger()
            }
        }
    }

    // For people who were not defined, check if it's the host
    if (!IsDedicatedServer() && (FindPlayerClass(plr).steamid.tostring() == GetSteamID(1).tostring())) {
        // It is, so we automatically give them max perms on the listen server
        Admins.push("[6]" + FindPlayerClass(plr).steamid)
        if (GetDeveloperLevelP2MM()) {
            SendChatMessage("Added max permissions for " + FindPlayerClass(plr).username + " as server operator.", plr)
        }
        return 6
    } else {
        // Not in Admins array nor are they the host, or it is a dedicated server
        return 0
    }
}

function SetAdminLevel(NewLevel, iPlayerIndex) {
    if (!IsDedicatedServer() && iPlayerIndex == 1) {
        SendChatMessage("[ERROR] Cannot change admin level of server operator!")
        return
    }

    local iAdminIndex = 0
    local bFoundIndex = false
    local tPlayerClass = FindPlayerClass(UTIL_PlayerByIndex(iPlayerIndex))
    foreach (admin in Admins) {
        // Separate the SteamID and the admin level
        local level = split(admin, "[]")[0]
        local SteamID = split(admin, "]")[1]

        if (SteamID == tPlayerClass.steamid.tostring()) {
            if (level == NewLevel) {
                SendChatMessage(tPlayerClass.username + "'s admin level is already " + level + ".")
                return
            }
            bFoundIndex = true
            break
        }
        iAdminIndex++
    }

    if (!bFoundIndex) {
        Admins.push("[" + NewLevel + "]" + tPlayerClass.steamid) // Add a new index in the Admins array
    } else {
        Admins.insert(iAdminIndex, "[" + NewLevel + "]" + tPlayerClass.steamid) // Insert updated admin at the existing index
        Admins.remove(iAdminIndex + 1) // REMOVE old copy of admin at the next index
    }

    // Send to everyone
    SendChatMessage("Set " + tPlayerClass.username + "'s admin level to " + NewLevel + ".")
}