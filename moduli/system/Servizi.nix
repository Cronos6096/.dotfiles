{
  # Tracking batteria
  services.upower.enable = true;
  services.blueman.enable = true;
  services.libinput.enable = true;
  services.power-profiles-daemon.enable = true;

  # OpenSSH daemon.
  services.openssh.enable = true;

  # Flatpak
  services.flatpak.enable = true;

  # Udiskie
  services.udisks2.enable = true;
  security.polkit.enable = true;
}
