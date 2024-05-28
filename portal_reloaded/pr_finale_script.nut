//PORTAL RELOADED SCRIPT FOR TIME TRAVEL CONCEPT
////////////////////////////////////////////////
//@author Jannis Brinkmann

speed_music <- Entities.FindByName(null, "@speed_music")

function checkCubeAngles(cube)		//called on player left area
{
	cube.SetAngles(0, 230, 0)
}

function resetCubeAngles(cube)
{
	cube.SetAngles(0, 0, 0)
}

function checkPortalAngles(portal)		//called on placed successfully
{
	if(portal.GetOrigin().x < -300 && portal.GetOrigin().x > -460 && portal.GetOrigin().y < -2480 && portal.GetOrigin().y > -2640)
	{
		if((portal.GetAngles().y < 135 && portal.GetAngles().y > 45) || (portal.GetAngles().y < -45 && portal.GetAngles().y > -135))
		{
			portal.SetOrigin(Vector(-384,-2560,portal.GetOrigin().z))
			portal.SetAngles(90,90,0)
		}
		else
		{
			portal.SetOrigin(Vector(-356,-2560,portal.GetOrigin().z))
			portal.SetAngles(90,0,0)
		}
		EntFire(portal.GetName(), "SetActivatedState", "1", 0.1)
	}
}

function checkPlayerSpeed()		//called twice every second
{
	if(player.GetVelocity().x > 300 || player.GetVelocity().x < -300 || player.GetVelocity().y > 300 || player.GetVelocity().y < -300 || player.GetVelocity().z > 300 || player.GetVelocity().z < -300)
	{
		EntFire(speed_music.GetName(), "Volume", "8")
	}
	else
	{
		EntFire(speed_music.GetName(), "Volume", "0")
	}
}