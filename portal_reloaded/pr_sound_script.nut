//PORTAL RELOADED SCRIPT FOR TIME TRAVEL CONCEPT
////////////////////////////////////////////////
//@author Jannis Brinkmann

voActive <- false
voSkipable <- false
voMapNumber <- 0
voNextNumber <- 0
voNextDuration <- 0
voNextIsSkipable <- false
mapNumberPrefix <- ""
voNumberPrefix <- ""
voTimer <- Entities.FindByName(null, "@vo_timer")

function playVO(mapNumber, voNumber, voDuration, voIsSkipable)
{
	voMapNumber <- mapNumber
	if(voActive == false || voSkipable == true)
	{
		mapNumberPrefix <- ""
		voNumberPrefix <- ""
		if(mapNumber < 10)
		{
			mapNumberPrefix <- "0"
		}
		if(voNumber < 10)
		{
			voNumberPrefix <- "0"
		}		
		voActive = true
		voSkipable = voIsSkipable
		setNext(0, 0, false)
		EntFire(voTimer.GetName(), "RefireTime", voDuration)
		EntFire(voTimer.GetName(), "ResetTimer")
		SendToConsole("play vo/announcer/pr_vo_m" + mapNumberPrefix + mapNumber + "_" + voNumberPrefix + voNumber)
		SendToConsole("cc_emit announcer.pr_vo_m" + mapNumberPrefix + mapNumber + "_" + voNumberPrefix + voNumber)
	}
	else
	{
		setNext(voNumber, voDuration, voIsSkipable)
	}
}

function voFinished()
{
	voActive = false
	if(voNextNumber > 0)
	{
		playVO(voMapNumber, voNextNumber, voNextDuration, voNextIsSkipable)
	}
}

function setNext(n, d, s)
{
	voNextNumber = n
	voNextDuration = d
	voNextIsSkipable = s
}