//PORTAL RELOADED SCRIPT FOR TIME TRAVEL CONCEPT
////////////////////////////////////////////////
//@author Jannis Brinkmann

timeportal <- Entities.FindByName(null, "@tp")
wportal1 <- Entities.FindByName(null, "@wportal1")
wportal2 <- Entities.FindByName(null, "@wportal2")
cleanser1 <- Entities.FindByName(null, "@tp_cleanser1")
cleanser2 <- Entities.FindByName(null, "@tp_cleanser2")
tp_position <- Vector(0,0,0)
tp_angles <- Vector(0,0,0)
tp_ramp <- false

function placeTimePortal()		//called when time portal is fired
{
	EntFire(wportal1.GetName(), "Close")
	wportal1.SetOrigin(timeportal.GetOrigin())
	wportal1.SetAngles(timeportal.GetAngles().x, timeportal.GetAngles().y, timeportal.GetAngles().z)
	wportal2.SetOrigin(Vector(timeportal.GetOrigin().x *-1, timeportal.GetOrigin().y *-1, timeportal.GetOrigin().z))		
	wportal2.SetAngles(timeportal.GetAngles().x, timeportal.GetAngles().y + 180, timeportal.GetAngles().z)
	
	if(timeportal.GetAngles().x > 10 || timeportal.GetAngles().x < -10)
	{
		EntFire(Entities.FindByName(null, "@tp_helper").GetName(), "Disable")
		EntFire(Entities.FindByName(null, "@tp_push").GetName(), "SetValue", "1")	
	}
	else 
	{
		EntFire(Entities.FindByName(null, "@tp_helper").GetName(), "Enable")
		EntFire(Entities.FindByName(null, "@tp_helper_ml").GetName(), "Open")
		EntFire(Entities.FindByName(null, "@tp_push").GetName(), "SetValue", "0")
	}
	
	EntFire(timeportal.GetName(), "SetActivatedState", "0", 0.01)
	EntFire(timeportal.GetName(), "RunScriptCode", "openTimePortal()", 0.02)
}	

function openTimePortal()
{
	EntFire(wportal1.GetName(), "Open")	
}

function removeTimePortal()		//called when time portal is briefly removed to allow new placement
{
	if(tp_ramp == false)	//not needed if time portal is currently on a func_brush
	{
		tp_position = wportal1.GetOrigin()
		tp_angles = wportal1.GetAngles()
		EntFire(wportal1.GetName(), "Close")
		timeportal.SetOrigin(Vector(0,0,0))
		wportal1.SetOrigin(Vector(0,0,0))
		wportal2.SetOrigin(Vector(0,0,0))
		EntFire(timeportal.GetName(), "SetActivatedState", "1", 0.01)
	}
}

function deleteTimePortal()		//called when time portal is temporarilly removed from the map
{
	tp_position = Vector(0,0,0)
	tp_angles = Vector(0,0,0)
	EntFire(wportal1.GetName(), "Close")
	timeportal.SetOrigin(Vector(0,0,0))
	wportal1.SetOrigin(Vector(0,0,0))
	wportal2.SetOrigin(Vector(0,0,0))
	EntFire(timeportal.GetName(), "SetActivatedState", "1", 0.01)	
}

function fizzleTimePortal()		//called when time portal is fizzled
{	
	EntFire(Entities.FindByName(null, "@tp1_light").GetName(), "TurnOff")
	EntFire(Entities.FindByName(null, "@tp2_light").GetName(), "TurnOff")
	EntFire(timeportal.GetName(), "RunScriptCode", "deleteTimePortal()", 0.01)
}

function checkPosition()	//called when time portal hits target
{
	if(timeportal.GetOrigin().y > -1 && timeportal.GetOrigin().y < 1)	//if no portal surface was hit, place time portal on previous position
	{
		timeportal.SetOrigin(tp_position)
		timeportal.SetAngles(tp_angles.x, tp_angles.y, tp_angles.z)
		placeTimePortal()				
	}
}

function setPlayerVelocity()	//called when player passes through floor-bound timeportal
{
	if(player.GetVelocity().z > 0 && player.GetVelocity().z < 300)
	{
		player.SetVelocity(Vector(player.GetVelocity().x, player.GetVelocity().y, 300))	
	}
	else if(player.GetVelocity().z < 0 && player.GetVelocity().z > -300)
	{
		player.SetVelocity(Vector(player.GetVelocity().x, player.GetVelocity().y, -300))
	}	
}

function updateCleansers()
{
	if(((player.GetOrigin().y < 0) && (wportal1.GetOrigin().y < 0)) || ((player.GetOrigin().y > 0) && (wportal1.GetOrigin().y > 0)))
	{
		EntFire(cleanser1.GetName(), "Disable")
		EntFire(cleanser2.GetName(), "Enable")
	}
	else if(((player.GetOrigin().y < 0) && (wportal2.GetOrigin().y < 0)) || ((player.GetOrigin().y > 0) && (wportal2.GetOrigin().y > 0)))
	{
		EntFire(cleanser2.GetName(), "Disable")
		EntFire(cleanser1.GetName(), "Enable")
	}
}	

function tpOnRamp()
{
	tp_ramp <- true
}

function tpOffRamp()
{
	tp_ramp <- false
}