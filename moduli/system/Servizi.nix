{ lib, config, ... }:
with lib;
{
  config = mkIf config.moduli.system.servizi.enable {
    services = {
      upower.enable = true;
      blueman.enable = true;
      libinput.enable = true;
      power-profiles-daemon.enable = true;

      openssh.enable = true;

      udisks2.enable = true;
    };

    security.polkit.enable = true;

    # Kde connect
    programs.kdeconnect.enable = true;
    networking.firewall.allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    networking.firewall.allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
  };
}
