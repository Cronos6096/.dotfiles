{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
{
  config = mkIf config.moduli.system.vm.enable {
    programs.virt-manager.enable = true;

    programs.dconf.enable = true;

    users.users.gcis.extraGroups = [ "libvirtd" ];

    environment.systemPackages = with pkgs; [
      OVMF
      qemu_kvm
      spice
      spice-gtk
      spice-protocol
      virt-manager
      virt-viewer
      win-spice
      virtio-win
    ];

    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          swtpm.enable = true;
        };
      };
      spiceUSBRedirection.enable = true;
    };
    services.spice-vdagentd.enable = true;
  };
}
