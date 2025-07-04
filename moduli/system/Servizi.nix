{ pkgs, ... }:
{
  # Tracking batteria
  services.upower.enable = true;
  services.blueman.enable = true;
  services.libinput.enable = true;
  services.power-profiles-daemon.enable = true;

  # OpenSSH daemon.
  services.openssh.enable = true;

  # Udiskie
  services.udisks2.enable = true;
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
}
