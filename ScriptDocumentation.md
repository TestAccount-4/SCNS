# SCNS VScripts Library Documentation

This Vscripts library has many script functions and scripts that can do various things.

# 1. Main Script Functions

## 1a. [`Mapspawn`](Mapspawn.nut)

`Mapspawn`, contains a bunch of script functions which can do various things. Most functions are meant to be used mid-game.

### New Script Functions

| Function | Description | Example Usage | Extra Notes |
| --- | --- | --- | --- |
| `MPTP(PlayerIndex,PlayerIndex)` | Teleports a player to a player origin. | MPTP(2,1) | arg1 is the origin arg2 is moved to |
| `PlacePortal(Portal Pair #, Portal #, Position, Angle)` | Works like portal_place, places a portal anywhere. | PlacePortal(1,1,host.GetOrigin()) | Portal Pair # 1=atlas pair and 2 = p-body pair |
| `SetPlayerModel(PlayerIndex,ModelName)` | Sets the model of a player. | SetPlayerModel(1,"models/error.mdl") | **Model MUST be precached or else the game will crash!** |
| `GetPicker()` | Returns the instance that you're looking at. | local picker = GetPicker() |  |
| `FindObject(Object Instance)` | Displays a hint at the object specified. | FindObject(FindByEntIndex(32)) | Hint does not have text. |
| `SetLobbyMovie(filepath)` | Plays a movie of your choice in the main lobby. | SetLobbyMovie("media/attract01.bik") | Can only be executed once. |
| `FindByEntIndex(EntIndex)` | Returns the index of an entity based off of a provided Entity Index | local host = FindByEntIndex(1) | Parameter must be an integer. |
| `SetPlayerTeam(PlayerIndex,Team)` | Sets the team of a player based off of their player index. | SetPlayerTeam(1,2) | Team 0 = SinglePlayer, Team 2 = Orange and team 3 = Blue |
| `KillPlayer(PlayerIndex)` | Kills a player. | KillPlayer(1) | Functions almost exactly like the `Kill` console command, except it uses player index instead of the steam names. |
| `SwapPlayerThing()` | Swaps the positions and angles of player 1 and 2 of the coop session. | SwapPlayerThing() | Does not swap portals or swap velocity and can break some chambers if done at the wrong time and place. | `ReturnParm(Instance)` | Returns what is specified. Can be useful when you want to put an action on something that isn't defined as an instance. | ReturnParm(Entities.FindByClassname("env_portal_laser").Destroy() | Does not just work for instances, can also work for anything else, even null instances. |
| `GiveLaserEyes(PlayerIndex,)` |


### New Variables

| Variable = defaultvar | Purpose | Example | Extra Notes |
| --- | --- | --- | --- |
| `forgivingpaint = false` | When changed to true, enables paint spread for all droppers, making it more 'forgiving'. | forgivingpaint = true | Does not change anything when changed back to `false`. |
| `IdleText = false` | When changed to true, enables text at the bottom left of the screen saying that the server is idle. | IdleText = true | Meant for mmod servers, allows changing back to false. |
| `NoclipState = false` | Toggle between giving noclip state to player 1 or 2. | NoclipState = true;includescript("test01") | Meant for the noclip script, is toggled when script test02 is run. |

## 1b. [`AutoExec`](autoexec.cfg)

This file contains various console command aliases or functions. **SAR is required for any command in autoexec.cfg to work!**

### New Console Commands

| Command | Description | Extra Notes |
| --- | --- | --- |
| `rickend` | Makes rick sing and completes level. | Explodes bots in order to proceed. |
| `showchatkey` | Shows a chat hint to make another player chat. | Goes away after around 5 seconds. |
| `showremoteviewkey` | Shows a remote view hint to make them view your perspective. | Goes away after around 5 seconds |
| `blah` | Makes glados say 'blah' | This is not just a sound, it can override GLaDOS's dialogue if executed. |
| `connectportals` | Connects both player's portals. | Both players have only 1 pair total and script breaks after death. |
| `launchplayer` | Launches both players upward at 10,000 velocity | VERY fast. |
| `spawncubeintervals` | Spawns a cube or ball from a dropper every second. | Can lag and can clog droppers. |
| `swapteams` | Swaps player teams, including their player models. | Only works once per map. |
| `+scns_place1` | When bound, will allow the host to place a portal on any surface. | If held down, the other player can also place theirs. | **Requires cvar-unhide!** |
| `+scns_place2` | When bound, will allow the host to place a portal on any surface. | If held down, the other player can also place theirs. | **Requires cvar-unhide!** |
| `scns_bindportalplaceanywhere` | Binds mouse1 and mouse2 to +scns_place1 and +scns_place2. | Does not require cheats. |

### New Console Functions

| Function/Command | Description | Example Usage | Extra Notes |
| --- | --- | --- | --- |
| `scns_findpartner <Player Instance>` | Creates a hint at the player to let the other player know where you or they are. | scns_findpartner FindByEntIndex(1)| Does not have text and can be on any object, not just players. |
| `scns_MPTP <PlayerIndex> <PlayerIndex>` | Teleports a player to another player. | scns_MPTP 2 1 | arg1 is the origin arg2 is moved to |
| `scns_kill <PlayerIndex>` | Kills a player. | scns_kill 2 | Functions almost exactly like the kill command, but without cheats and with player indexes instead of steam names. |
| `scns_setlinearforce_global <integer>`| Sets the speed of every excursion funnel on the map. | scns_setlinearforce_global -300 | If set to negative, it will reverse the funnel polarity. |
| `scns_setlinearforce <integer>` | Sets speed of the funnel you're looking at. | scns_setlinearforce 600 | Difficult to get instance of a funnel by !picker, use scns_setlinearforce_global instead. |
| `scns_setlobbymovie <filepath>` | Plays a movie of your choice in the main lobby. | scns_setlobbymovie "media/attract01.bik" | Does not work if not used in lobby. |

# 2. Info on every script

There are around 75 scripts in SCNS and their function or purpose may not be what they seem, this table is meant to clear up some questions you may have about some scripts in SCNS.

| Name | Description | Working or not |
| --- | --- | --- |
| `atlasradio` | Setup script, ignore | Works |
| `BECOMEFAST` | Makes you faster. | Broken |
| `blahcommand` | Modified multiplayer mod script to add a command which makes GLaDOS say "blah" | Broken |
| `bluelasereyes` | Makes a laser which shoots from blue's eyes. | Works (OBSOLETE!! Use GiveLaserEyes() function instead!) |
| `cometogethereveryone` | Supposed to fling both players together. | Completely Broken |
| `cometomeorange` | **LITERAL CHAOS** | Works |
| `COMETOMYEYES` | Teleports your partner to you. - Works (Partially)
| `connectportals` | Connects both you and your partner's portals. | Works |
| `coopintroduction` | Makes you say a ChatGPT generated introduction to coop in chat. | Works |
| `createbrush` | Originally used to test creating a brush, but repurposed for a failed turret creation script. | Broken |
| `delcatapults` | Deletes catapult triggers from `cometogethereveryone` script | Broken |
| `displayonbluehead` | Tries to create a vgui entity and parent it to blue. | Broken **(Crashes game if used!)** |
| `displaytext` | Displays text on-screen for both players defined within its file. | Works |
| `dissolvecube` | Fizzles the object you're currently looking at. | Works |
| `finalelobby` | Turns the hub into a Wheatley-controlled version of itself. (Agonzo320/SCN's version.) | Unfinished |
| `fogscript` | Covers the map within a thick fog. | Works |
| `givenoclip` | Erased early noclip script | Ignore |.
| `givepotatogun` | Supposed to give any player a potato-modified portal gun. | Broken |
| `goback` | Teleports you and your partner back to your spawn points | Broken |
| `hubcontrol` | Turns the hub into a Wheatley-esque version of itself. (Crunch Brunch's version.) | Works |
| `hubscare` | Turns the hub into a "horror"-esque version. (OUTDATED! USE `hubtrolle` INSTEAD!) | Works |
| `hubtrolle` | Newer version of `hubscare` | Works |
| `kp_1-9 & kp_reset & kp_forward & kp_backward` | Script system which can let you change to any map in base coop | Works |
| `launchplayers` | Launches both Atlas and P-body upward at 10,000 velocity. | Works |
| `libtest` | Pcapture-lib script | Ignore |
| `LOOKATRED` | Forces Atlas's camera to look at P-body | Broken |
| `makecubebouncy` | Covers the object you're currently looking at in Repulsion Gel. | Works |
| `makecubespeedy` | Covers the object you're currently looking at in Propulsion Gel. | Works |
| `mapspawn` | Complex script, visit [readme](readme.md) and [**Main Script Functions**](https://github.com/TestAccount-4/SCNS/blob/main/ScriptDocumentation.md#1a-mapspawn) section for more information. | Works (Mostly) |
| `movecatapult` | Moves a catapult in lobby to orange and its target to blue, launching orange to blue. | Works but makes course 06 inescapeable |
| `mp_coop_race_2` | Leftover script from Colored Partners, meant for debugging purposes. | Broken |
| `mp_coop_rat_maze_advanced` | Scrapped version of an advanced version of mp_coop_rat_maze. | Works |
| `publicsetnewmodel` | Sets a player model to something else (Use `SetNewModel` instead!) | Works |
| `replaceorangewithatlas` | Swaps the model of orange and blue, does not change teams | Works |
| `replacetriggerhurt` | Tries to replace every trigger_hurt within a map to a trigger_catapult. | Broken |
| `resetmodel` | Resets the model of blue. | Works |
| `rickend` | Plays the Adventure Core's singing before exploding the bots and transitioning to the next level. | Works |
| `sayXXX` | Random scripts that say random stuff. (Literally) | Works |
| `sncscrazylasermod` | - Failed concept, might be reused in the future | Broken |
| `scripttimedelay` | Setup script for a time delay function and automatically executed. Please check **Main Script Functions** for more information on this. | Works |
| `setgravity` | Self explanatory. | Broken |
| `setnewmodel` | Sets the model of blue or orange to any model in the game, as long as it's precached | Works |
| `skiptonextlevel` | Skips to the next level (OBSOLETE, use transition_map console command instead.) | Works |
| `spawnXXX` | Failed attempts at spawning things. | Broken |
| `spawncube` | Only `spawnXXX` script that actually spawns something, it spawns a cube with no physics and cannot be picked up | Works (except no physics) |
| `swapmodelwithpicker` | Swaps your model with the thing you're currently looking at. | Works |
| `swapteams` | Swaps the actual teams of the players and their models (also precaches model skins, so that's a plus) | Works |
| `test01` | **The** Customizable noclip script. (In SCNS.) | Works |
| `test02` | Alternates between giving noclip to blue or orange | Works |
| `testfunctions` | P2MM File, used for debugging purposes | Ignore |
| `Warning` | Setup script. Spawns a hint based off of parameters defined within the file. Used for `FindPartner` function and `FindObject()` script function. | Works |
| `YOUCANTHIDEFROMROTATY` | Originally purposed for setting up for the "Chaos" script, but repurposed after a rewrite of the chaos script for another failed spawning attempt. | Broken |




### [Info on SCNS](readme.md)
