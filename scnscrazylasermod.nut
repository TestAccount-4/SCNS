//(
//   ____   ____ _   _ _                                  _                                          _ 
//  / ___| / ___| \ | ( )___    ___ _ __ __ _ _____   _  | | __ _ _______ _ __   _ __ ___   ___   __| |
//  \___ \| |   |  \| |// __|  / __| '__/ _` |_  / | | | | |/ _` |_  / _ \ '__| | '_ ` _ \ / _ \ / _` |
//   ___) | |___| |\  | \__ \ | (__| | | (_| |/ /| |_| | | | (_| |/ /  __/ |    | | | | | | (_) | (_| |
//  |____/ \____|_| \_| |___/  \___|_|  \__,_/___|\__, | |_|\__,_/___\___|_|    |_| |_| |_|\___/ \__,_|
//                                                 |___/                                                
//))))

//  By Agonzo320(Formerly known as ServerClown, aka SCN.)

IncludeScript("ppmod3.nut");
if(!("lava" in this)) {

  ::lava <- {};
  lava.level <- {};
  lava.auto <- Entities.CreateByClassname("logic_auto");

  lava.waitplayer <- function() {
    ppmod.interval(function() {

      local red = Entities.FindByName(null, "red");
      if(red && red.IsValid()) {

        ppmod.text(function(obj) {

          obj.SetColor("255 255 255");
          obj.SetPosition(-1, 0.85);
          obj.SetEffect(0);
          obj.SetFade(0, 0, 0);
          obj.SetChannel(5);

          lava.text <- obj;
          lava.spawn();

        });

        ppmod.fire("lava_waitplayer", "Kill");

      }

    }, 0, "lava_waitplayer");
  }

  ppmod.addoutput(lava.auto, "OnMapTransition", "lava.waitplayer()");
  ppmod.addscript(lava.auto, "OnNewGame", "lava.waitplayer()");
  SendToConsole("sv_cheats 1")
  switch(GetMapName()){
  case "mp_coop_lobby_3":
      EntFire("@command", "Command", "sv_cheats 1", 0);
  }
}

ppmod.create("env_instructor_hint", function(hint0) {

    hint0.SetOrigin( Vector(-33, -38, 65) );
    hint0.SetAngles( 0, 0, 0 );

    ppmod.keyval(hint0, "Targetname", "hint1");
    ppmod.keyval(hint0, "hint_Color", "255 255 255");
    ppmod.keyval(hint0, "hint_allow_nodraw_target", "1");
    ppmod.keyval(hint0, "hint_icon_offscreen", "icon_tip");
    ppmod.keyval(hint0, "hint_icon_onscreen", "icon_tip");
    ppmod.keyval(hint0, "hint_static", "1");
    ppmod.keyval(hint0, "hint_caption", "");
    ppmod.keyval(hint0, "hint_timeout", "5");

  });

	
SendToConsole("say  COOP mod!!"
      EntFire("trigger_once", "addoutput", "OnStartTouch hint1:showhint::", 1)
      EntFire("trigger_once", "addoutput", "OnStartTouch @command:command:clear:")
      EntFire("@command", "Command", "say thx for playing the reverse COOP mod!!!")
    SendToConsole("clear", 1)
    // Lighting hack
    SendToConsole("mat_ambient_light_r 0.00");
    SendToConsole("mat_ambient_light_g 0.00");
    SendToConsole("mat_ambient_light_b 0.00");
      EntFire("@command", "Command", "sv_cheats 0", 1);
      break
)