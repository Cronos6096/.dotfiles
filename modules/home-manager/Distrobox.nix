{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
{
  config = mkIf config.moduli.home-manager.distrobox.enable {
    programs.distrobox.enable = true;

    home.packages = with pkgs; [
      distrobox-tui
    ];
  };
}
