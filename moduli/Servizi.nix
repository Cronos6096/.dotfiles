{
  # OpenSSH daemon.
  services.openssh.enable = true;

  # Flatpak
  services.flatpak.enable = true;

  # Udiskie
  services.udisks2.enable = true;
  security.polkit.enable = true;
}
