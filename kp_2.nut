//// kp_2 script code. \\\\

// Script made by Agonzo320 (Formerly known as ServerClown)

// Course 02

if (NumValue01a == null)NumValue01a <- 0;

if(NumValue01a==1)
{
	SendToConsole("changelevel mp_coop_fling_3")
}
if(NumValue01a==2)
{
	SendToConsole("changelevel mp_coop_infinifling_train")
}
if(NumValue01a==3)
{
	SendToConsole("changelevel mp_coop_come_along")
}
if(NumValue01a==4)
{
	SendToConsole("changelevel mp_coop_fling_1")
}
if(NumValue01a==5)
{
	SendToConsole("changelevel mp_coop_catapult_1")
}
if(NumValue01a==6)
{
	SendToConsole("changelevel mp_coop_multifling_1")
}
if(NumValue01a==7)
{
	SendToConsole("changelevel mp_coop_fling_crushers")
}
if(NumValue01a==8)
{
	SendToConsole("changelevel mp_coop_fan")
}

// If NumValue01a is too large, then print
if(NumValue01a>=9)
{
	print("Invalid map, redirecting to last map.")
	SendToConsole("changelevel mp_coop_fan")
}

//// Test Code
//if(NumValue01a=="")
//{
//	SendToConsole("changelevel ")
//}