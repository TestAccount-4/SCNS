CommandList.push(
    class {
        name = "p2mm"
        level = 5

        // !p2mm (string)
        function CC(p, args) {
            try{
                args[0] = strip(args[0])
            } catch (exception) {
                SendChatMessage("Type in a valid string.")
                return
            }

            if (args.len() == 0) {
                SendChatMessage("Type in a string.", p)
                return
            }

            // local videoname = "coop_bots_load"
            // if (args[0] == 0) {
            //     videoname = "coop_bots_load_wave"
            // }

            // for (local ent; ent = Entities.FindByClassname(ent, "player");) {
            //     EntFireByHandle(p2mm_clientcommand, "Command", "playvideo_end_level_transition " + videoname + " 1", 0, ent, ent)
            // }
            local joinedString = "";

            foreach (key, value in args) {
                // Concatenate each value into joinedString
                joinedString += value;
            }
            SendChatMessage(joinedString)
            // SendChatMessage(args[0])
        }
    }
)