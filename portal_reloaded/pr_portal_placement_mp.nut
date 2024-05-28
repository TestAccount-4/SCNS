//PORTAL RELOADED SCRIPT FOR TIME TRAVEL CONCEPT
////////////////////////////////////////////////
//@author Jannis Brinkmann

portal1 <- Entities.FindByName(null, "@p1")
portal2 <- Entities.FindByName(null, "@p2")
portal3 <- Entities.FindByName(null, "@p3")
portal4 <- Entities.FindByName(null, "@p4")

function onPortalPlaced()
{	
	if(self.GetOrigin().x < 0)
	{
		if(self.GetName() == "@p1")
		{
			placePortal(portal3, portal1)
		}
		else if(self.GetName() == "@p2")
		{
			placePortal(portal4, portal2)
		}
	}
}

function placePortal(portalToPlace, portalToCopy)
{
	if((Entities.FindByName(null, "red").GetVelocity().z < 100) && (Entities.FindByName(null, "red").GetVelocity().z > -100))
	{
		EntFire(portalToPlace.GetName(), "SetActivatedState", "0")
	}
	portalToPlace.SetOrigin(Vector(portalToCopy.GetOrigin().x *-1, portalToCopy.GetOrigin().y *-1, portalToCopy.GetOrigin().z))
	portalToPlace.SetAngles(portalToCopy.GetAngles().x, portalToCopy.GetAngles().y + 180, portalToCopy.GetAngles().z)
	EntFire(portalToPlace.GetName(), "SetActivatedState", "1")
}

function setPortalID(cplayer)
{	
	if(cplayer.GetName() == "blue")
	{
		if(cplayer.GetOrigin().x < 0)
		{
			SendToConsole("change_portalgun_linkage_id 1")
		}
		else
		{
			SendToConsole("change_portalgun_linkage_id 0")
		}
	}
}