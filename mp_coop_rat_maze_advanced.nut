triggera_1 <- ppmod.trigger(Vector(-224,544,-320), Vector(64,64,64), "trigger_multiple");
    ppmod.keyval(triggera_1,"damagetype","0");
    ppmod.keyval(triggera_1,"spawnflags","4097");
    ppmod.keyval(triggera_1,"damage","100");
    ppmod.fire(triggera_1,"Enable");
    ppmod.addscript(triggera_1,"OnStartTouch",function(activator,caller) {
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
    },0.0,-1,true)
    triggera_2 <- ppmod.trigger(Vector(-864,544,-320), Vector(64,64,64), "trigger_multiple");
    ppmod.keyval(triggera_2,"damagetype","0");
    ppmod.keyval(triggera_2,"spawnflags","4097");
    ppmod.keyval(triggera_2,"damage","1000");
    ppmod.fire(triggera_2,"Enable");
    ppmod.addscript(triggera_2,"OnStartTouch",function(activator,caller) {
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
    },0.0,-1,true)
    triggera_3 <- ppmod.trigger(Vector(-864,544,-576), Vector(64,64,64), "trigger_multiple");
    ppmod.keyval(triggera_3,"damagetype","0");
    ppmod.keyval(triggera_3,"spawnflags","4097");
    ppmod.keyval(triggera_3,"damage","1000");
    ppmod.fire(triggera_3,"Enable");
    ppmod.addscript(triggera_3,"OnStartTouch",function(activator,caller) {
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
    },0.0,-1,true)
    triggera_4 <- ppmod.trigger(Vector(-224,544,-704), Vector(64,64,64), "trigger_multiple");
    ppmod.keyval(triggera_4,"damagetype","0");
    ppmod.keyval(triggera_4,"spawnflags","4097");
    ppmod.keyval(triggera_4,"damage","1000");
    ppmod.fire(triggera_4,"Enable");
    ppmod.addscript(triggera_4,"OnStartTouch",function(activator,caller) {
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
    },0.0,-1,true)
    triggerb_1 <- ppmod.trigger(Vector(-480,544,-704), Vector(64,64,64), "trigger_multiple");
    ppmod.keyval(triggerb_1,"damagetype","0");
    ppmod.keyval(triggerb_1,"spawnflags","4097");
    ppmod.keyval(triggerb_1,"damage","1000");
    ppmod.fire(triggerb_1,"disable");
    ppmod.addscript(triggerb_1,"OnStartTouch",function(activator,caller) {
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
    },0.0,-1,true)
    triggerb_2 <- ppmod.trigger(Vector(-608,544,-320), Vector(64,64,64), "trigger_multiple");
    ppmod.keyval(triggerb_2,"damagetype","0");
    ppmod.keyval(triggerb_2,"spawnflags","4097");
    ppmod.keyval(triggerb_2,"damage","1000");
    ppmod.fire(triggerb_2,"disable");
    ppmod.addscript(triggerb_2,"OnStartTouch",function(activator,caller) {
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
      ppmod.fire(activator,"sethealth",0)
    },0.0,-1,true)
    local triggerclean1 = ppmod.trigger(Vector(-480,536,-321), Vector(322, 64, 64), "trigger_portal_cleanser");
    ppmod.keyval(triggerclean1,"spawnflags","4097");
    ppmod.keyval(triggerclean1,"targetname","scns_triggerclean1")
    ppmod.fire("@command","command","ent_bbox scns_triggerclean1")
    ppmod.fire(triggerclean1,"Enable");
    ToggleBBox <- false
    ppmod.interval(function() {
      if (ToggleBBox == false) {
        dev.DrawEntityBBox(triggera_1, 0.5)
        dev.DrawEntityBBox(triggera_2, 0.5)
        dev.DrawEntityBBox(triggera_3, 0.5)
        dev.DrawEntityBBox(triggera_4, 0.5)
      } else if (ToggleBBox == true) {
        dev.DrawEntityBBox(triggerb_1, 0.5)
        dev.DrawEntityBBox(triggerb_2, 0.5)
      }
    },0.5)
    IncludeScript("SRC/aperturekit")
    Precache("world/laser_cut.wav");
    local deathswapbutton = ppmod.button("prop_floor_button", Vector(-256,32,-637)).then(function (button) {
    button.OnPressed(function () {
      ToggleBBox <- true
      local blue = ppmod.get("blue")
      print("pressed");
      ppmod.fire(triggera_1,"disable");
      ppmod.fire(triggera_2,"disable");
      ppmod.fire(triggera_3,"disable");
      ppmod.fire(triggera_4,"disable");
      ppmod.fire(triggerb_1,"Enable");
      ppmod.fire(triggerb_2,"Enable");
      blue.EmitSound("world/laser_cut.wav")
    });

    button.OnUnpressed(function () {
      ToggleBBox <- false
      local blue = ppmod.get("blue")
      print("unpressed");
      ppmod.fire(triggera_1,"Enable");
      ppmod.fire(triggera_2,"Enable");
      ppmod.fire(triggera_3,"Enable");
      ppmod.fire(triggera_4,"Enable");
      ppmod.fire(triggerb_1,"disable");
      ppmod.fire(triggerb_2,"disable");
      blue.EmitSound("world/laser_cut.wav")
    });

  });
  ppmod.fire(deathswapbutton,"color","255,255,0")