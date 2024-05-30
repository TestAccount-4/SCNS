# SCNS VScripts Library Documentation

This library consists of several modules that can be extremely useful for you when developing VScripts for Portal 2.

## 1. [Mapspawn](Mapspawn.nut)

`Mapspawn`, contains a bunch of script functions which can do various things. Most functions are meant to be used mid-game

### [`AutoExec`](autoexec.cfg)

This file contains basic algebraic functions such as finding minimum and maximum values, clamping numbers, rounding, and remapping values.

| Function | Description | Usage | Extra Notes |
| --------------- | ------------------------------------------------------------------------- |
| `MPTP(PlayerIndex,PlayerIndex)` | Teleports a player to a player origin. | MPTP(2,1) | arg1 is the origin arg2 is moved to |
| `PlacePortal(Portal Pair #, Portal #, Position, Angle)` | Works like portal_place, places a portal anywhere. | PlacePortal(1,1,host.GetOrigin() | Portal Pair # works differently than portal_place, 1=atlas pair and 2 = p-body pair |
| `SetPlayerModel(PlayerIndex,ModelName)` | Sets the model of a player. | SetPlayerModel(1,"models/props/metal_box.mdl") |  |
| Other Functions are to be written at a later date. |  |  |  |

### [Info on SCNS](readme.md)
