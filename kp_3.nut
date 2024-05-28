//// kp_3 script code. \\\\

// Script made by Agonzo320 (Formerly known as ServerClown)

// Course 03

if (NumValue01a == null)NumValue01a <- 0;

if(NumValue01a==1)
{
	SendToConsole("changelevel mp_coop_wall_intro")
}
if(NumValue01a==2)
{
	SendToConsole("changelevel mp_coop_wall_2")
}
if(NumValue01a==3)
{
	SendToConsole("changelevel mp_coop_catapult_wall_intro")
}
if(NumValue01a==4)
{
	SendToConsole("changelevel mp_coop_wall_block")
}
if(NumValue01a==5)
{
	SendToConsole("changelevel mp_coop_catapult_2")
}
if(NumValue01a==6)
{
	SendToConsole("changelevel mp_coop_turret_walls")
}
if(NumValue01a==7)
{
	SendToConsole("changelevel mp_coop_turret_ball")
}
if(NumValue01a==8)
{
	SendToConsole("changelevel mp_coop_wall_5")
}


// If NumValue01a is too large, then print
if(NumValue01a>=9)
{
	print("Invalid map, redirecting to last map.")
	SendToConsole("changelevel mp_coop_wall_5")
}

//// Test Code
//if(NumValue01a=="")
//{
//	SendToConsole("changelevel ")
//}