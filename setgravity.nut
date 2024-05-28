  ppmod.player(FindByEntIndex(1)).then(function (pplayer) {

    // Note: this will fire for every +attack input, even if the player can't shoot portals
    pplayer.gravity(0.5)

  });