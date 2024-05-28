//PORTAL RELOADED SCRIPT FOR TIME TRAVEL CONCEPT
////////////////////////////////////////////////
//@author Jannis Brinkmann

cl <- Entities.FindByName(null, "@changeLevel")
levelId <- 0

function incLevelId()
{
	if(levelId > 8)
	{
		levelId = 1
	}
	else 
	{
		levelId = levelId + 1
	}
	setScreenMovie()
}

function decLevelId()
{
	if(levelId < 2)
	{
		levelId = 9
	}
	else 
	{
		levelId = levelId - 1
	}
	setScreenMovie()
}

function changeLevel()
{
	if(levelId == 1)
	{
		EntFire(cl.GetName(), "Command", "changelevel mp_coop_pr_cubes")
	}
	else if(levelId == 2)
	{
		EntFire(cl.GetName(), "Command", "changelevel mp_coop_pr_portals")
	}
	else if(levelId == 3)
	{
		EntFire(cl.GetName(), "Command", "changelevel mp_coop_pr_teamwork")
	}
	else if(levelId == 4)
	{
		EntFire(cl.GetName(), "Command", "changelevel mp_coop_pr_fling")
	}
	else if(levelId == 5)
	{
		EntFire(cl.GetName(), "Command", "changelevel mp_coop_pr_loop")
	}
	else if(levelId == 6)
	{
		EntFire(cl.GetName(), "Command", "changelevel mp_coop_pr_catapult")
	}
	else if(levelId == 7)
	{
		EntFire(cl.GetName(), "Command", "changelevel mp_coop_pr_laser")
	}
	else if(levelId == 8)
	{
		EntFire(cl.GetName(), "Command", "changelevel mp_coop_pr_bridge")
	}
	else if(levelId == 9)
	{
		EntFire(cl.GetName(), "Command", "changelevel mp_coop_pr_tbeam")
	}
	else
	{
		EntFire(cl.GetName(), "Command", "changelevel mp_coop_lobby_3")
	}
}

function setScreenMovie()
{
	if(levelId == 1)
	{
		EntFire(Entities.FindByName(null, "@lsl1").GetName(), "Enable")
		EntFire(Entities.FindByName(null, "@lss1").GetName(), "Enable")
	}
	else if(levelId == 2)
	{
		EntFire(Entities.FindByName(null, "@lsl2").GetName(), "Enable")
		EntFire(Entities.FindByName(null, "@lss2").GetName(), "Enable")
	}
	else if(levelId == 3)
	{
		EntFire(Entities.FindByName(null, "@lsl3").GetName(), "Enable")
		EntFire(Entities.FindByName(null, "@lss3").GetName(), "Enable")
	}
	else if(levelId == 4)
	{
		EntFire(Entities.FindByName(null, "@lsl4").GetName(), "Enable")
		EntFire(Entities.FindByName(null, "@lss4").GetName(), "Enable")
	}
	else if(levelId == 5)
	{
		EntFire(Entities.FindByName(null, "@lsl5").GetName(), "Enable")
		EntFire(Entities.FindByName(null, "@lss5").GetName(), "Enable")
	}
	else if(levelId == 6)
	{
		EntFire(Entities.FindByName(null, "@lsl6").GetName(), "Enable")
		EntFire(Entities.FindByName(null, "@lss6").GetName(), "Enable")
	}
	else if(levelId == 7)
	{
		EntFire(Entities.FindByName(null, "@lsl7").GetName(), "Enable")
		EntFire(Entities.FindByName(null, "@lss7").GetName(), "Enable")
	}
	else if(levelId == 8)
	{
		EntFire(Entities.FindByName(null, "@lsl8").GetName(), "Enable")
		EntFire(Entities.FindByName(null, "@lss8").GetName(), "Enable")
	}
	else if(levelId == 9)
	{
		EntFire(Entities.FindByName(null, "@lsl9").GetName(), "Enable")
		EntFire(Entities.FindByName(null, "@lss9").GetName(), "Enable")
	}
}

function setEndPositionVC(team)
{
	if(team.GetName() == "blue")
	{		
		vc1 <- Entities.FindByName(null, "@vc_blue")
		vc1.SetOrigin(Vector(team.GetOrigin().x, team.GetOrigin().y, team.GetOrigin().z + 70))
		vc1.SetAngles(team.GetAngles().x, team.GetAngles().y, team.GetAngles().z)
	}
	else if(team.GetName() == "red")
	{
		vc2 <- Entities.FindByName(null, "@vc_orange")
		vc2.SetOrigin(Vector(team.GetOrigin().x, team.GetOrigin().y, team.GetOrigin().z + 70))
		vc2.SetAngles(team.GetAngles().x, team.GetAngles().y, team.GetAngles().z)
	}
}

function setEndPositionPL(team)
{
	if(team.GetName() == "blue")
	{		
		et1 <- Entities.FindByName(null, "@end_target_blue")
		team.SetVelocity(Vector(0,0,0))
		team.SetOrigin(et1.GetOrigin())
		team.SetAngles(et1.GetAngles().x, et1.GetAngles().y, et1.GetAngles().z)
	}
	else if(team.GetName() == "red")
	{
		et2 <- Entities.FindByName(null, "@end_target_orange")
		team.SetVelocity(Vector(0,0,0))
		team.SetOrigin(et2.GetOrigin())
		team.SetAngles(et2.GetAngles().x, et2.GetAngles().y, et2.GetAngles().z)
	}
}

function BlowUpBots()
{	
	CoopGladosBlowUpBots() // this calls the function in game code
}