local hint = entLib.CreateByClassname("env_instructor_hint", {
  hint_allow_nodraw_target = 1,
  hint_alphaoption = 0,
  hint_binding = "say",
  hint_color = "255 255 255",
  hint_forcecaption = 0,
  hint_caption = "This is your partner."
  hint_icon_offscreen = "icon_arrow_plain",
  hint_icon_offset = 0,
  hint_icon_onscreen = "icon_tip",
  hint_timeout = 0,
  hint_pulseoption = 0,
  hint_shakeoption = 0,
  hint_static = 0,
  hint_range = 0,
  hint_local_player_only = 0,
  hint_target = "blue",
  targetname = UniqueString("scns_chathint")
})
ppmodhint <- ppmod.get(hint.GetName())
ppmod.fire(ppmodhint,"ShowHint")