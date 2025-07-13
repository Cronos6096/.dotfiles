{ pkgs, ... }:
let
  ovmfDescriptor = ''
    {
      "description": "OVMF (NixOS passthrough)",
      "interface-types": ["uefi"],
      "mapping": {
        "device": "flash",
        "executable": {
          "filename": "/usr/share/OVMF/OVMF_CODE.fd",
          "format": "raw"
        },
        "nvram": {
          "filename": "/usr/share/OVMF/OVMF_VARS.fd",
          "format": "raw"
        }
      },
      "targets": [
        {
          "architecture": "x86_64",
          "machines": ["q35", "pc"]
        }
      ],
      "persistent": true
    }
  '';
in
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

  boot = {
    kernelParams = [
      "amd_iommu=on"
      "iommu=pt"
      "vfio-pci.ids=10de:25a0,10de2291"
    ];
    initrd.kernelModules = [
      "vfio_pci"
      "vfio"
      "vfio_iommu_type1"
      "amdgpu"
    ];
  };

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        runAsRoot = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;

  # Virt Manager che non vede ovmf
  fileSystems."/usr/share/OVMF" = {
    device = "/run/libvirt/nix-ovmf";
    fsType = "none";
    options = [ "bind" ];
  };
  fileSystems."/usr/share/edk2/ovmf" = {
    device = "/run/libvirt/nix-ovmf";
    fsType = "none";
    options = [ "bind" ];
  };

  environment.etc."libvirt/firmware/ovmf.json".text = ovmfDescriptor;
  systemd.units."libvirtd.service".wantedBy = [ "multi-user.target" ];
  systemd.services."libvirtd.service".serviceConfig.Restart = "always";
}
