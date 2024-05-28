//PORTAL RELOADED SCRIPT FOR TIME TRAVEL CONCEPT
////////////////////////////////////////////////
//@author Jannis Brinkmann

music_present <- Entities.FindByName(null, "@music_present")
music_future <- Entities.FindByName(null, "@music_future")
playerInPresent <- false

function checkPlayerPosition()
{
	if(player.GetOrigin().y < 0)
	{
		playerInPresent <- true
	}
	else	
	{
		playerInPresent <- false
	}
	setMusicVolume()	
}

function setMusicVolume()
{
	EntFire(music_present.GetName(), "Volume", "10")
	if(playerInPresent == true)
	{
		EntFire(music_future.GetName(), "Volume", "1")
	}
	else
	{
		EntFire(music_future.GetName(), "Volume", "7")
	}
}