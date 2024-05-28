//PORTAL RELOADED SCRIPT FOR TIME TRAVEL CONCEPT
////////////////////////////////////////////////
//@author Jannis Brinkmann

portal1 <- Entities.FindByName(null, "@p1")
portal2 <- Entities.FindByName(null, "@p2")
portal3 <- Entities.FindByName(null, "@p3")
portal4 <- Entities.FindByName(null, "@p4")
inFuture <- Entities.FindByName(null, "@player_in_future")
ghosting <- Entities.FindByName(null, "@ghosting_active")
rampState <- true
hintActive <- true

function rampEqual()
{
	rampState = true
}

function rampNotEqual()
{
	rampState = false
}

function rampPortalCheck(portal)
{
	if(rampState == false)
	{
		if(portal == 0)	//Time Portal
		{
			EntFire(Entities.FindByName(null, "@tp").GetName(), "RunScriptCode", "fizzleTimePortal()", 0.1)
			if(hintActive == true)
			{
				hintActive = false
				EntFire(Entities.FindByName(null, "@vo_timer").GetName(), "RunScriptCode", "playVO(5,3,8,true)", 0.1)
			}			
		}
		else if(portal == 1)	//Blue Portal
		{
			EntFire(portal3.GetName(), "SetActivatedState", "0", 0.1)
		}
		else if(portal == 2)	//Orange Portal
		{
			EntFire(portal4.GetName(), "SetActivatedState", "0", 0.1)
		}
	}
}

function resetBluePortal()
{
	portal3.SetOrigin(Vector(0,0,0))
	portal3.SetAngles(0,0,0)
}

function placeBluePortal()	//called when blue portal is fired
{	
	portal3.SetOrigin(Vector(portal1.GetOrigin().x *-1, portal1.GetOrigin().y *-1, portal1.GetOrigin().z))
	portal3.SetAngles(portal1.GetAngles().x, portal1.GetAngles().y + 180, portal1.GetAngles().z)
}

function resetOrangePortal()
{
	portal4.SetOrigin(Vector(0,0,0))
	portal4.SetAngles(0,0,0)
}

function placeOrangePortal()	//called when orange portal is fired
{
	portal4.SetOrigin(Vector(portal2.GetOrigin().x *-1, portal2.GetOrigin().y *-1, portal2.GetOrigin().z))
	portal4.SetAngles(portal2.GetAngles().x, portal2.GetAngles().y + 180, portal2.GetAngles().z)	
}

function setPortalID()	//called when player passes time portal
{	
	if(player.GetOrigin().y < 0)	//player in present
	{
		SendToConsole("change_portalgun_linkage_id 0")
		EntFire(inFuture.GetName(), "SetValue", "0")
		placeGhost(1, portal1)
		placeGhost(2, portal2)
	}
	else	//player in future
	{
		SendToConsole("change_portalgun_linkage_id 1")
		EntFire(inFuture.GetName(), "SetValue", "1")
		placeGhost(1, portal3)
		placeGhost(2, portal4)
	}
	EntFire(ghosting.GetName(), "Test")
}

function placeGhost(ghost, portal)
{
	if(ghost == 1)
	{
		Entities.FindByName(null, "@ghosting_blue").SetOrigin(portal.GetOrigin())
		Entities.FindByName(null, "@ghosting_blue").SetAngles(portal.GetAngles().x, portal.GetAngles().y, portal.GetAngles().z)
	}
	else if(ghost == 2)
	{
		Entities.FindByName(null, "@ghosting_orange").SetOrigin(portal.GetOrigin())
		Entities.FindByName(null, "@ghosting_orange").SetAngles(portal.GetAngles().x, portal.GetAngles().y, portal.GetAngles().z)
	}
}