IncludeScript("ppmod3.nut");
local launchplayerup = function(player1,upforce) {
    local targetplayer = player1
    local targetplayervelocity = targetplayer.GetVelocity()
    targetplayer.SetVelocity(Vector(targetplayervelocity.x,targetplayervelocity.y,upforce))
}

local blue = ppmod.get("blue")
local red = ppmod.get("red")


launchplayerup(blue,15000)
launchplayerup(red,15000)