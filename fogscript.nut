switch(GetMapName()){
case "mp_coop_tbeam_drill":
EntFire("lighting-environment_bts", "kill", 1)
break
case "mp_coop_tbeam_catch_grind_1":
EntFire("environment_bts", "kill", 1)
break
case "mp_coop_tbeam_laser_1":
EntFire("coop_lighting-environment_bts", "kill", 1)
break
case "mp_coop_lobby_3":
EntFire("env_fog_controller", "SetEndDist", "400", 0.3)
break
case "mp_coop_lobby_2":
EntFire("env_fog_controller", "SetEndDist", "400", 0.3)
break
case "mp_coop_paint_crazy_box":
EntFire("team_door-exit_door-proxy", "addoutput", "onproxyrelay1 env_fog_controller:setenddist:186:3.01", 1)
EntFire("team_door-exit_door-proxy", "addoutput", "onproxyrelay1 env_fog_controller:setenddist:186:3.1", 1)
EntFire("both_players_in_rl", "addoutput", "OnTrigger env_fog_controller:setenddist:90000:", 1)
break
}
EntFire("func_areaportal", "open")
EntFire("env_fog_controller", "SetColorSecondary", "70 75 80")
EntFire("env_fog_controller", "SetColor", "70 75 80")
EntFire("env_fog_controller", "SetStartDist", "-64")
EntFire("env_fog_controller", "SetEndDist", "186")
EntFire("env_fog_controller", "SetMaxDensity", 1)
EntFire("team_door-exit_door-proxy", "addoutput", "onproxyrelay1 env_fog_controller:setenddist:90000:3", 1)
EntFire("@relay_exit_door_open", "addoutput", "OnTrigger env_fog_controller:setenddist:90000:3", 1)
EntFire("vault-relay_start_cameras", "addoutput", "OnTrigger env_fog_controller:setenddist:90000:3", 1)
EntFire("InstanceAuto9-relay_exit_succeed", "addoutput", "OnTrigger env_fog_controller:setenddist:90000:3", 1)
EntFire("InstanceAuto9-ElevatorRoomEntranceTrigger", "addoutput", "OnTrigger env_fog_controller:setenddist:90000:3", 1)
EntFire("InstanceAuto9-start_malfunction_rl", "addoutput", "OnTrigger env_fog_controller:setenddist:12:", 1)
EntFire("InstanceAuto2-relay_exit_succeed", "addoutput", "OnTrigger env_fog_controller:setenddist:90000:3", 1)
EntFire("portal_bts_team_door-exit_door-proxy", "addoutput", "onproxyrelay1 env_fog_controller:setenddist:90000:3", 1)
EntFire("instanceauto35-elevatorroomentrancetrigger", "addoutput", "OnStartTouch env_fog_controller:setenddist:90000:3", 1)
EntFire("instanceauto8-elevatorroomentrancetrigger", "addoutput", "OnStartTouch env_fog_controller:setenddist:90000:3", 1)
EntFire("loader_door", "addoutput", "OnOpen env_fog_controller:setenddist:90000:3", 1)
EntFire("bts_nightvision_disable", "addoutput", "OnTrigger env_fog_controller:setenddist:186:0.1", 1)
EntFire("bts_nightvision_fade_to_black", "addoutput", "OnTrigger env_fog_controller:setenddist:186:0.1", 1)
EntFire("bts_nightvision_enable", "addoutput", "OnTrigger env_fog_controller:setenddist:186:0.1", 1)