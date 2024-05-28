//// kp_1 script code. \\\\

// Script made by Agonzo320 (Formerly known as ServerClown)

// Course 01

if (NumValue01a == null)NumValue01a <- 0;

if(NumValue01a==1)
{
	SendToConsole("changelevel mp_coop_doors")
}
if(NumValue01a==2)
{
	SendToConsole("changelevel mp_coop_race_2")
}
if(NumValue01a==3)
{
	SendToConsole("changelevel mp_coop_laser_2")
}
if(NumValue01a==4)
{
	SendToConsole("changelevel mp_coop_rat_maze")
}
if(NumValue01a==5)
{
	SendToConsole("changelevel mp_coop_laser_crusher")
}
if(NumValue01a==6)
{
	SendToConsole("changelevel mp_coop_teambts")
}



// If NumValue01a is too large, then print
if(NumValue01a>="7")
{
	print("Invalid map, redirecting to last map.")
	SendToConsole("changelevel mp_coop_teambts")
}

//// Test Code
//if(NumValue01a=="")
//{
//SendToConsole("changelevel ")
//}