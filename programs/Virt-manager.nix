{
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["andme"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
}