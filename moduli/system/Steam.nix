{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
{
  config = mkIf config.moduli.system.steam.enable {
    programs = {
      steam.enable = true;
      steam.gamescopeSession.enable = true;
      gamemode.enable = true;
    };

    environment.systemPackages = with pkgs; [
      adwsteamgtk
    ];
  };
}
