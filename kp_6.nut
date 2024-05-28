//// kp_6 script code. \\\\

// Script made by Agonzo320 (Formerly known as ServerClown)

// Course 06

if (NumValue01a == null)NumValue01a <- 0;

if(NumValue01a==1)
{
	SendToConsole("changelevel mp_coop_separation_1")
}
if(NumValue01a==2)
{
	SendToConsole("changelevel mp_coop_tripleaxis")
}
if(NumValue01a==3)
{
	SendToConsole("changelevel mp_coop_catapult_catch")
}
if(NumValue01a==4)
{
	SendToConsole("changelevel mp_coop_2paints_1bridge")
}
if(NumValue01a==5)
{
	SendToConsole("changelevel mp_coop_paint_conversion")
}
if(NumValue01a==6)
{
	SendToConsole("changelevel mp_coop_bridge_catch")
}
if(NumValue01a==7)
{
	SendToConsole("changelevel mp_coop_laser_tbeam")
}
if(NumValue01a==8)
{
	SendToConsole("changelevel mp_coop_paint_rat_maze")
}
if(NumValue01a==9)
{
	SendToConsole("changelevel mp_coop_paint_crazy_box")
}



// If NumValue01a is too large, then print
if(NumValue01a>=10)
{
	print("Invalid map, redirecting to last map.")
	SendToConsole("changelevel mp_coop_paint_crazy_box")
}

//// Test Code
//if(NumValue01a=="")
//{
//	SendToConsole("changelevel ")
//}