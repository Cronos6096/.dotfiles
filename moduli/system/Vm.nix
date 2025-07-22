{ pkgs, ... }:
{
  programs.virt-manager.enable = true;

  programs.dconf.enable = true;

  users.users.gcis.extraGroups = [ "libvirtd" ];

  environment.systemPackages = with pkgs; [
    OVMF
    qemu_kvm
    pkgs.adwaita-icon-theme
    polkit
    spice
    spice-gtk
    spice-protocol
    virt-manager
    virt-viewer
    win-spice
    win-virtio
  ];

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;
}
