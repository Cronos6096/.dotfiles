{ pkgs, ... }:

{
  programs.dconf.enable = true;
  
  users.users.gcis.extraGroups = [ "libvirtd" ];
  
  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    polkit
    spice 
    spice-gtk
    spice-protocol
    win-virtio
    win-spice
    pkgs.adwaita-icon-theme
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