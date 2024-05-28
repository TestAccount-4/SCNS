local MapName = GetMapName() //Gets the map name.
// script MarkMapComplete(tostring(MapName)) //Marks current map as complete.

// Other Maps

if(MapName=="mp_coop_lobby_3")
{
	SendToConsole("say SCNS: No map after mp_coop_lobby_3, please try this on another map.")
}
if(MapName=="mp_coop_lobby_2")
{
	SendToConsole("say SCNS: No map after mp_coop_lobby_2, please try this on another map.")
}
if(MapName=="mp_coop_community_hub")
{
	SendToConsole("say SCNS: No map after mp_coop_community_hub, please try this on another map.")
}

// Course 00

if(MapName=="mp_coop_start")
{
	SendToConsole("changelevel mp_coop_lobby_3")
}

// Course 01

if(MapName=="mp_coop_doors")
{
	SendToConsole("changelevel mp_coop_race_2")
}
if(MapName=="mp_coop_race_2")
{
	SendToConsole("changelevel mp_coop_laser_2")
}
if(MapName=="mp_coop_laser_2")
{
	SendToConsole("changelevel mp_coop_rat_maze")
}
if(MapName=="mp_coop_rat_maze")
{
	SendToConsole("changelevel mp_coop_laser_crusher")
}
if(MapName=="mp_coop_laser_crusher")
{
	SendToConsole("changelevel mp_coop_teambts")
}
if(MapName=="mp_coop_teambts")
{
	SendToConsole("changelevel mp_coop_lobby_3")
}

// Course 02

if(MapName=="mp_coop_fling_3")
{
	SendToConsole("changelevel mp_coop_infinifling_train")
}
if(MapName=="mp_coop_infinifling_train")
{
	SendToConsole("changelevel mp_coop_come_along")
}
if(MapName=="mp_coop_come_along")
{
	SendToConsole("changelevel mp_coop_fling_1")
}
if(MapName=="mp_coop_fling_1")
{
	SendToConsole("changelevel mp_coop_catapult_1")
}
if(MapName=="mp_coop_catapult_1")
{
	SendToConsole("changelevel mp_coop_multifling_1")
}
if(MapName=="mp_coop_multifling_1")
{
	SendToConsole("changelevel mp_coop_fling_crushers")
}
if(MapName=="mp_coop_fling_crushers")
{
	SendToConsole("changelevel mp_coop_fan")
}
if(MapName=="mp_coop_fan")
{
	SendToConsole("changelevel mp_coop_lobby_3")
}

// Course 03

if(MapName=="mp_coop_wall_intro")
{
	SendToConsole("changelevel mp_coop_wall_2")
}
if(MapName=="mp_coop_wall_2")
{
	SendToConsole("changelevel mp_coop_catapult_wall_intro")
}
if(MapName=="mp_coop_catapult_wall_intro")
{
	SendToConsole("changelevel mp_coop_wall_block")
}
if(MapName=="mp_coop_wall_block")
{
	SendToConsole("changelevel mp_coop_catapult_2")
}
if(MapName=="mp_coop_catapult_2")
{
	SendToConsole("changelevel mp_coop_turret_walls")
}
if(MapName=="mp_coop_turret_walls")
{
	SendToConsole("changelevel mp_coop_turret_ball")
}
if(MapName=="mp_coop_turret_ball")
{
	SendToConsole("changelevel mp_coop_wall_5")
}
if(MapName=="mp_coop_wall_5")
{
	SendToConsole("changelevel mp_coop_lobby_3")
}

//Course 04

if(MapName=="mp_coop_tbeam_redirect")
{
	SendToConsole("changelevel mp_coop_tbeam_drill")
}
if(MapName=="mp_coop_tbeam_drill")
{
	SendToConsole("changelevel mp_coop_tbeam_catch_grind_1")
}
if(MapName=="mp_coop_tbeam_catch_grind_1")
{
	SendToConsole("changelevel mp_coop_tbeam_laser_1")
}
if(MapName=="mp_coop_tbeam_laser_1")
{
	SendToConsole("changelevel mp_coop_tbeam_polarity")
}
if(MapName=="mp_coop_tbeam_polarity")
{
	SendToConsole("changelevel mp_coop_tbeam_polarity2")
}
if(MapName=="mp_coop_tbeam_polarity2")
{
	SendToConsole("changelevel mp_coop_tbeam_polarity3")
}
if(MapName=="mp_coop_tbeam_polarity3")
{
	SendToConsole("changelevel mp_coop_tbeam_maze")
}
if(MapName=="mp_coop_tbeam_maze")
{
	SendToConsole("changelevel mp_coop_tbeam_end")
}
if(MapName=="mp_coop_tbeam_end")
{
	SendToConsole("changelevel mp_coop_lobby_3")
}

// Course 05

if(MapName=="mp_coop_paint_come_along")
{
	SendToConsole("changelevel mp_coop_paint_redirect")
}
if(MapName=="mp_coop_paint_redirect")
{
	SendToConsole("changelevel mp_coop_paint_redirect")
}
if(MapName=="mp_coop_paint_redirect")
{
	SendToConsole("changelevel mp_coop_paint_walljumps")
}
if(MapName=="mp_coop_paint_walljumps")
{
	SendToConsole("changelevel mp_coop_paint_speed_fling")
}
if(MapName=="mp_coop_paint_speed_fling")
{
	SendToConsole("changelevel mp_coop_paint_red_racer")
}
if(MapName=="mp_coop_paint_red_racer")
{
	SendToConsole("changelevel mp_coop_paint_speed_catch")
}
if(MapName=="mp_coop_paint_speed_catch")
{
	SendToConsole("changelevel mp_coop_paint_longjump_intro")
}
if(MapName=="mp_coop_paint_longjump_intro")
{
	SendToConsole("changelevel mp_coop_credits")
}
if(MapName=="mp_coop_credits")
{
	SendToConsole("changelevel mp_coop_lobby_3")
}

// Course 06

if(MapName=="mp_coop_separation_1")
{
	SendToConsole("changelevel mp_coop_tripleaxis")
}
if(MapName=="mp_coop_tripleaxis")
{
	SendToConsole("changelevel mp_coop_catapult_catch")
}
if(MapName=="mp_coop_catapult_catch")
{
	SendToConsole("changelevel mp_coop_2paints_1bridge")
}
if(MapName=="mp_coop_2paints_1bridge")
{
	SendToConsole("changelevel mp_coop_paint_conversion")
}
if(MapName=="mp_coop_paint_conversion")
{
	SendToConsole("changelevel mp_coop_bridge_catch")
}
if(MapName=="mp_coop_bridge_catch")
{
	SendToConsole("changelevel mp_coop_laser_tbeam")
}
if(MapName=="mp_coop_laser_tbeam")
{
	SendToConsole("changelevel mp_coop_paint_rat_maze")
}
if(MapName=="mp_coop_paint_rat_maze")
{
	SendToConsole("changelevel mp_coop_paint_crazy_box")
}
if(MapName=="mp_coop_paint_crazy_box")
{
	SendToConsole("changelevel mp_coop_lobby_3")
}

