IncludeScript("ppmod3.nut");
local blue = ppmod.get("blue")
local red = ppmod.get("red")
IncludeScript("SRC/aperturekit")
Precache("vo/core03/singing01.wav")
Precache("vo/core03/singing02.wav")

//blue.EmitSound("vo/glados/chellgladoswakeup06.wav")
Entities.FindByName(null,"@glados").EmitSound("vo/core03/singing01.wav")
ppmod.wait(function() {
    Precache("vo/core03/singing02.wav")
    Entities.FindByName(null,"@glados").EmitSound("vo/core03/singing02.wav")
    CoopGladosBlowUpBots()
    ppmod.wait(function() {
        ppmod.fire("@command","command","transition_map")
    },4)
},7.2)