//PORTAL RELOADED SCRIPT FOR TIME TRAVEL CONCEPT
////////////////////////////////////////////////
//@author Jannis Brinkmann

position <- Vector(0,0,0)
moved <- false
carriedBy <- null
partnerCarriedBy <- null
name <- "empty"
cp <- Entities.FindByName(null, "cube_particles")
fdrop <- Entities.FindByName(null, "@forceCubeDrop")
bd <- Entities.FindByName(null, "@box_dissolver")
partnerDissolved <- false

function dissolveCube(cube)		//called when present cube moved
{
	partner <- Entities.FindByName(null, "partner_" + cube.GetName())
	if(partnerDissolved == false)	//partner cube is not already dissolved
	{
		if(partnerCarriedBy != null) 
		{ 
			fdrop.SetOrigin(partnerCarriedBy.GetOrigin())
			EntFire(fdrop.GetName(), "Enable")			
		}
		partnerDissolved = true
		cp.SetOrigin(partner.GetOrigin())
		EntFire(Entities.FindByName(null, "@trigger_box_fizzle_sound").GetName(), "Trigger")
		EntFire(Entities.FindByName(null, "showCubeParticles").GetName(), "Trigger")
		EntFire(Entities.FindByName(null, "@cs").GetName(), "RunScriptCode", "dissolveDelayed(partner)", 0.2)
	}
	else
	{
		partner.SetOrigin(Vector(0,0,0))
	}
}

function dissolveDelayed(partner)
{
	partner.SetOrigin(Vector(0,0,0))
}

function cubePickedUp(team)
{
	carriedBy = team
}

function cubeDropped()
{
	carriedBy = null
	moved = true
}

function partnerPickedUp(team)
{
	partnerCarriedBy = team
}

function partnerDropped()
{
	partnerCarriedBy = null
}

function moveCube(cube)		//called when present cube's veloctiy changes to 0
{
	partner <- Entities.FindByName(null, "partner_" + cube.GetName())
	if(cube.GetOrigin().y < 0)		//cube is in the present
	{
		if(cube.GetName() == name)
		{
			partner.SetOrigin(Vector(cube.GetOrigin().x *-1, cube.GetOrigin().y *-1, cube.GetOrigin().z + 15))
		}
		else
		{
			partner.SetOrigin(Vector(cube.GetOrigin().x *-1, cube.GetOrigin().y *-1, cube.GetOrigin().z))
		}		
		partner.SetAngles(cube.GetAngles().x + 180, cube.GetAngles().y, cube.GetAngles().z + 180)
		EntFire(partner.GetName(), "EnableMotion")
		partnerDissolved = false
	}
}

function checkPositionChange(cube) //called 4 times every second
{		
	if(cube.GetOrigin().x > 0)
	{
		bd.SetOrigin(cube.GetOrigin())
	}
	else if(carriedBy != null)
	{
		dissolveCube(cube)
	}
	else
	{
		if(((cube.GetOrigin().x - position.x) > 1 || (cube.GetOrigin().x - position.x) < -1) || //has cube moved 
		   ((cube.GetOrigin().y - position.y) > 1 || (cube.GetOrigin().y - position.y) < -1) ||
		   ((cube.GetOrigin().z - position.z) > 1 || (cube.GetOrigin().z - position.z) < -1))
		{	
			dissolveCube(cube)
			moved = true
		}
		else
		{
			if(moved == true)
			{	
				pCube <- cube
				cp.SetOrigin(Vector(cube.GetOrigin().x *-1, cube.GetOrigin().y *-1, cube.GetOrigin().z))
				EntFire(Entities.FindByName(null, "@trigger_box_appear_sound").GetName(), "Trigger")
				EntFire(Entities.FindByName(null, "showCubeParticles").GetName(), "Trigger")
				EntFire(Entities.FindByName(null, "@cs").GetName(), "RunScriptCode", "moveCube(pCube)", 0.2)
				moved = false
			}
		}
		position = cube.GetOrigin()
	}		
}

function setCubeName(cube) //called when present-cube is placed on button in the present
{
	name = cube.GetName()
}

function deleteCubeName() //called when present-cube leaves button in the present
{
	name = "empty"
}