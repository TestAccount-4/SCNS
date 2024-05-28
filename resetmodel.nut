//-----------------------------------------------------------------------------
// Models to choose from. (Not every model.)
//-----------------------------------------------------------------------------

//---Other Models
//models/player/ballbot/ballbot.mdl											(doens't work if you have a different skin)
//models/player/eggbot/eggbot.mdl 											(doens't work if player has a different skin)
//models/props/portal_door_combined.mdl 									(every course except course 05)
//models/props_underground/underground_weighted_cube.mdl 					(only works for course 05)
//models/player/bot_assembly/assembly_station.mdl   						(crashes on course 06 and 05)
//models/props/faith_plate.mdl 												(Works for any map with a faith plate in it.)
//models/props/metal_box.mdl 												(Only works for maps with NORMAL cubes in it.)
//models/props_backstage/item_dropper.mdl									(prob only works for mp_coop_community_hub and that one level in course 06 where you 'fix' the assembly machines)


//---Lobby Only Models (Can sometimes work for other maps, but not likely.)
//models/props/lab_monitor_pose01/lab_monitor_pose03.mdl
//models/props/vert_door/vert_door_upper.mdl
//models/props_bts/hanging_walkway_128c.mdl
//models/props_gameplay/screen_button.mdl
//models/props_bts/gantry_rails_a.mdl (Big thing that opens when course 06 buttons are revealed.)

//-----------------------------------------------------------------------------
// Predefined functions
//-----------------------------------------------------------------------------

local MODEL1 = "models/player/ballbot/ballbot.mdl" //Model you want to set here (MUST be within the level or precached via creation commands.)
local Partner = 1 //Pick 1 to select Blue(Atlas) or 2 to pick Pbody(Orange) and 3 for custom.

//-----------------------------------------------------------------------------
// Precache (Broken)
//-----------------------------------------------------------------------------
//function Precache()
//{
//    PrecacheModel(MODEL1);
//}
//Precache();

//-----------------------------------------------------------------------------
// SetModel Script
//-----------------------------------------------------------------------------

if (Partner == 1) {
	local ent = null;     
	while(ent = Entities.FindByName(ent, "blue"))
	{
	ent.SetModel(MODEL1)
	}
} else {
	if (Partner == 2) {
		local ent = null;    
		while(ent = Entities.FindByName(ent, "red"))
		{
		ent.SetModel(MODEL1)
		}
	} else {
		if (Partner == 3) {
			local ent = null;     
			while(ent = Entities.FindByClassname(ent, "*"))
			ent.SetModel(MODEL1)
			print("should have done it.")
		} else {
			print("Defined local instance of Partner not specified within the specified range, please select either 1 or 2 for this instance.")
		}
	}
}