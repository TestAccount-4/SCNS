//// kp_4 script code. \\\\

// Script made by Agonzo320 (Formerly known as ServerClown)

// Course 04

if (NumValue01a == null)NumValue01a <- 0;

if(NumValue01a==1)
{
	SendToConsole("changelevel mp_coop_tbeam_redirect")
}
if(NumValue01a==2)
{
	SendToConsole("changelevel mp_coop_tbeam_drill")
}
if(NumValue01a==3)
{
	SendToConsole("changelevel mp_coop_tbeam_catch_grind_1")
}
if(NumValue01a==4)
{
	SendToConsole("changelevel mp_coop_tbeam_laser_1")
}
if(NumValue01a==5)
{
	SendToConsole("changelevel mp_coop_tbeam_polarity")
}
if(NumValue01a==6)
{
	SendToConsole("changelevel mp_coop_tbeam_polarity2")
}
if(NumValue01a==7)
{
	SendToConsole("changelevel mp_coop_tbeam_polarity3")
}
if(NumValue01a==8)
{
	SendToConsole("changelevel mp_coop_tbeam_maze")
}
if(NumValue01a==9)
{
	SendToConsole("changelevel mp_coop_tbeam_end")
}


// If NumValue01a is too large, then print
if(NumValue01a>=10)
{
	print("Invalid map, redirecting to last map.")
	SendToConsole("changelevel mp_coop_tbeam_end")
}

//// Test Code
//if(NumValue01a=="")
//{
//	SendToConsole("changelevel ")
//}