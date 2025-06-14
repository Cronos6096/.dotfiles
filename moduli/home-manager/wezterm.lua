tab_bar_at_bottom = true,
hide_tab_bar_if_only_one_tab = false,

config.visual_bell = {
  fade_in_function = 'EaseIn',
  fade_in_duration_ms = 150,
  fade_out_function = 'EaseOut',
  fade_out_duration_ms = 150,
},

config.keys = {
{
  key = "t",
  mods = "CTRL|SHIFT",
  action = "ActivateCommandPalette",
},
{
  key = "n",
  mods = "ALT",
  action = "SpawnWindow",
},
{
  key = "l",
  mods = "ALT",
  action = "ScrollByPage(1)",
},
{
  key = "h",
  mods = "ALT|SHIFT",
  action = "MoveTab(1)",
},
{
  key = "w",
  mods = "ALT",
  action = "CloseCurrentPane",
},
}
return config
