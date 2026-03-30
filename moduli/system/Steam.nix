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
      steam = {
        enable = true;
        extraCompatPackages = with pkgs; [
          proton-ge-bin
        ];
        gamescopeSession.enable = true;
      };
      gamemode.enable = true;
    };

    environment.systemPackages = with pkgs; [
      adwsteamgtk
    ];
  };
}
