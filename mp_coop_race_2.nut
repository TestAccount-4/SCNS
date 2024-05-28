ppmod.getall(["prop_weighted_cube"],function (cube) { /////////////////////////////////////////////1
      print("cubeishere!")
      cubeIndex <- cube.entindex();
      if (cubeStates.cubeIndex == null||!cubeStates.cubeIndex) {
        ::cubeStates.cubeIndex <- false;
      }
       local start = pplayer-eyes.GetOrigin();
       local end = start + pplayer-eyes.GetForwardVector() * 256;
       local portal = null, portals = [];
       while (portal = ppmod.get("prop_portal", portal)) portals.push(portal);
       // If the ray didn't intersect anything, don't draw a box.
       local ray = ppmod.ray(start, end, cube, true, portal)
       if (ray.fraction == 1.0) {print("nointersect");return}

       // If the ray hit a cube, draw a green box. Otherwise, draw a red box.
       if (ray.entity) {
        if (GetDeveloperLevel() == 5.6) {
          DebugDrawBox(ray.point, Vector(-2, -2, -2), Vector(2, 2, 2), 0, 255, 0, 100, -1);
        }
        local currentcubestate = cubeStates.cubeIndex;
         if (currentcubestate == false) {
          ppmod.fire(cube,"disablemotion");
          cubeStates.cubeIndex <- true;
         } else if (currentcubestate == true) {
          ppmod.fire(cube,"enablemotion");
          cubeStates.cubeIndex <- false;
         } 
        print("found it, no freeze tho")
       } else {
         if (GetDeveloperLevel() == 5.6) {
          DebugDrawBox(ray.point, Vector(-2, -2, -2), Vector(2, 2, 2), 255, 0, 0, 100, -1);
        }
        print("not found")
       }
      
    })//end of cube hook function