{ lib, config, ... }:
with lib;
{
  programs.wezterm = {
    enable = mkIf config.moduli.home-manager.wezterm.enable true;
  };

  xdg.configFile = {
    "wezterm/wezterm.lua".source = ./wezterm.lua;
  };
}
