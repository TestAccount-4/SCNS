local blue = entLib.FindByName("blue")
local host = FindByEntIndex(1)
local laser1 = Entities.CreateByClassname("env_portal_laser")
local newblueori = host.GetOrigin()

laser1.SetOrigin(host.GetOrigin())
print(laser1.GetOrigin())
print(host.GetOrigin())
ppmod.fire(laser1,"setparent",host.GetName())
ppmod.fire(laser1,"turnon")
ppmod.fire(laser1,"setlocalangles","-5.7391,0,0")


// AttachEyeControlToPlayers()
// local traceSettings = TracePlus.Settings.new({
//     ignoreClasses = arrayLib.new("worldspawn"),
// })
// local traceResult = TracePlus.FromEyes.Bbox(100, blue, traceSettings)
// if (traceResult.DidHit()) {
//     local hitEntity = traceResult.GetEntity()
// if (hitEntity) {
//     printl("Trace hit entity:" + hitEntity.GetClassname())
// } else {
//     printl("Trace hit the world.")
// }
// }