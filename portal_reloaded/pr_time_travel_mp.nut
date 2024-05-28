//PORTAL RELOADED SCRIPT FOR TIME TRAVEL CONCEPT
////////////////////////////////////////////////
//@author Jannis Brinkmann

timeportal <- Entities.FindByName(null, "@tp")
wportal1 <- Entities.FindByName(null, "@wportal1")
wportal2 <- Entities.FindByName(null, "@wportal2")
tpkiller <- Entities.FindByName(null, "@tp_killer")
tpkiller2 <- Entities.FindByName(null, "@tp_killer2")
tpblue <- Entities.FindByName(null, "@tp_blue")
tporange <- Entities.FindByName(null, "@tp_orange")
placementMod <- 0
spawnDest <- 0
tpActive <- false
player1 <- Entities.FindByName(null, "blue")
player2 <- Entities.FindByName(null, "red")
speed_music <- Entities.FindByName(null, "@speed_music")

function placeTimePortal()
{	
	EntFire(wportal1.GetName(), "Close")
	wportal1.SetOrigin(timeportal.GetOrigin())
	wportal1.SetAngles(timeportal.GetAngles().x, timeportal.GetAngles().y, timeportal.GetAngles().z)
	wportal2.SetOrigin(Vector(timeportal.GetOrigin().x *-1, timeportal.GetOrigin().y *-1, timeportal.GetOrigin().z))		
	wportal2.SetAngles(timeportal.GetAngles().x, timeportal.GetAngles().y + 180, timeportal.GetAngles().z)	
	EntFire(timeportal.GetName(), "SetActivatedState", "0", 0.00)
	
	if(timeportal.GetAngles().x > 10 || timeportal.GetAngles().x < -10)
	{
		EntFire(Entities.FindByName(null, "@tp_push").GetName(), "SetValue", "1")	
	}
	else 
	{
		EntFire(Entities.FindByName(null, "@tp_push").GetName(), "SetValue", "0")
		EntFire(Entities.FindByName(null, "@tp_helper_ml1").GetName(), "Open", "", 0.01)
		EntFire(Entities.FindByName(null, "@tp_helper_ml2").GetName(), "Open", "", 0.01)		
	}
	
	if(placementMod == 1)
	{
		EntFire(timeportal.GetName(), "RunScriptCode", "openTimePortal()", 0.00)
	}
	else if(placementMod == 2)
	{
		wportal2.SetAngles(wportal2.GetAngles().x, wportal2.GetAngles().y + 180, wportal2.GetAngles().z)
		EntFire(timeportal.GetName(), "RunScriptCode", "openTimePortal()", 0.05)
	}
	else
	{
		EntFire(timeportal.GetName(), "RunScriptCode", "openTimePortal()", 0.05)
	}
}

function openTimePortal()
{
	EntFire(wportal1.GetName(), "Open")	
	EntFire(tpkiller.GetName(), "Disable")
	EntFire(tpkiller2.GetName(), "Disable")
	EntFire(timeportal.GetName(), "RunScriptCode", "positionTriggers()", 0.05)
	tpActive = true
}

function positionTriggers()
{
	tpkiller.SetOrigin(wportal1.GetOrigin())
	tpkiller.SetAngles(wportal1.GetAngles().x, wportal1.GetAngles().y, wportal1.GetAngles().z)
	tpkiller2.SetOrigin(wportal2.GetOrigin())
	tpkiller2.SetAngles(wportal2.GetAngles().x, wportal2.GetAngles().y, wportal2.GetAngles().z)
}

function removeTimePortal()
{
	if(tpActive == true)
	{
		EntFire(wportal1.GetName(), "Close")
		timeportal.SetOrigin(Vector(0,0,0))
		wportal1.SetOrigin(Vector(0,0,0))
		wportal2.SetOrigin(Vector(0,0,0))
		EntFire(Entities.FindByName(null, "@tp_close_sound").GetName(), "PlaySound")
		EntFire(timeportal.GetName(), "SetActivatedState", "1", 0.01)
		EntFire(timeportal.GetName(), "RunScriptCode", "positionTriggers()", 0.05)	
		tpActive = false
	}
	else
	{
		EntFire(Entities.FindByName(null, "@inactive_sound").GetName(), "PlaySound")
	}	
}	

function setPlacementModifier(value)
{
	placementMod = value
}

function setSpawnDest(value)
{
	spawnDest = value
}

function setRespawnLocation(activePlayer)
{
	spawnTarget <- "@dest" + spawnDest
	if(activePlayer.GetOrigin().x < 0)
	{
		spawnTarget = spawnTarget + "_present"
	}
	else
	{
		spawnTarget = spawnTarget + "_future"
	}
	if(activePlayer.GetName() == "blue")
	{
		spawnTarget = spawnTarget + "_blue"
		EntFire(tpblue.GetName(), "SetRemoteDestination", spawnTarget)
	}
	else 
	{
		spawnTarget = spawnTarget + "_orange"
		EntFire(tporange.GetName(), "SetRemoteDestination", spawnTarget)
	}	
}

function setPlayerVelocity(activePlayer)
{	
	if(activePlayer.GetVelocity().z > 0 && activePlayer.GetVelocity().z < 300)
	{
		activePlayer.SetVelocity(Vector(activePlayer.GetVelocity().x, activePlayer.GetVelocity().y, 300))	
	}
	else if(activePlayer.GetVelocity().z < 0 && activePlayer.GetVelocity().z > -300)
	{
		activePlayer.SetVelocity(Vector(activePlayer.GetVelocity().x, activePlayer.GetVelocity().y, -300))
	}	
}

function InitSpeedCheck()
{
	player1 = Entities.FindByName(null, "blue")
	player2 = Entities.FindByName(null, "red")
	speed_music = Entities.FindByName(null, "@speed_music")
}

function checkPlayerSpeed()
{
	vx1 <- player1.GetVelocity().x
	vy1 <- player1.GetVelocity().y
	vz1 <- player1.GetVelocity().z
	vx2 <- player2.GetVelocity().x
	vy2 <- player2.GetVelocity().y
	vz2 <- player2.GetVelocity().z
	
	if(vx1 > 300 || vx1 < -300 || vy1 > 300 || vy1 < -300 || vz1 > 300 || vz1 < -300)
	{
		EntFire(speed_music.GetName(), "Volume", "8")	
	}
	else if(vx2 > 300 || vx2 < -300 || vy2 > 300 || vy2 < -300 || vz2 > 300 || vz2 < -300)
	{
		EntFire(speed_music.GetName(), "Volume", "8")
	}
	else
	{
		EntFire(speed_music.GetName(), "Volume", "0")
	}
}
