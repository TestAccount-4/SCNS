//// kp_5 script code. \\\\

// Script made by Agonzo320 (Formerly known as ServerClown)

// Course 05

if (NumValue01a == null)NumValue01a <- 0;

if(NumValue01a==1)
{
	SendToConsole("changelevel mp_coop_paint_come_along")
}
if(NumValue01a==2)
{
	SendToConsole("changelevel mp_coop_paint_redirect")
}
if(NumValue01a==3)
{
	SendToConsole("changelevel mp_coop_paint_bridge")
}
if(NumValue01a==4)
{
	SendToConsole("changelevel mp_coop_paint_walljumps")
}
if(NumValue01a==5)
{
	SendToConsole("changelevel mp_coop_paint_speed_fling")
}
if(NumValue01a==6)
{
	SendToConsole("changelevel mp_coop_paint_red_racer")
}
if(NumValue01a==7)
{
	SendToConsole("changelevel mp_coop_paint_speed_catch")
}
if(NumValue01a==8)
{
	SendToConsole("changelevel mp_coop_paint_longjump_intro")
}


// If NumValue01a is too large, then print
if(NumValue01a>=9)
{
	print("Invalid map, redirecting to last map.")
	SendToConsole("changelevel mp_coop_paint_longjump_intro")
}

//// Test Code
//if(NumValue01a=="")
//{
//	SendToConsole("changelevel ")
//}