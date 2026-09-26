{
  config,
  lib,
  pkgs,
  ...
}:
let
  lookingGlassSizeMb = 64;
in
{
  specialisation.gpu-passthrough = {
    configuration = {
      virtualisation = {
        libvirtd = {
          qemu = {
            swtpm.enable = true;
            runAsRoot = true;
            verbatimConfig = ''
              namespaces = []
              cgroup_device_acl = [
                "/dev/null", "/dev/full", "/dev/zero",
                "/dev/random", "/dev/urandom",
                "/dev/ptmx", "/dev/kvm", "/dev/kvmfr0",
                "/dev/net/tun"
              ]
            '';
          };
        };
        spiceUSBRedirection.enable = true;
      };
      services.spice-vdagentd.enable = true;

      boot = {
        kernelParams = [
          "amd_iommu=on"
          "iommu=pt"
          "vfio-pci.ids=10de:25a0,10de:2291"
        ];
        initrd.kernelModules = [
          "vfio_pci"
          "vfio"
          "vfio_iommu_type1"
          "amdgpu"
        ];

        # Looking Glass IVSHMEM via the kvmfr module
        extraModulePackages = [ config.boot.kernelPackages.kvmfr ];
        kernelModules = [ "kvmfr" ];
        extraModprobeConfig = "options kvmfr static_size_mb=${toString lookingGlassSizeMb}";
      };

      # Allow the kvm group to use the Looking Glass framebuffer
      services.udev.extraRules = ''
        SUBSYSTEM=="kvmfr", GROUP="kvm", MODE="0660"
      '';

      environment.systemPackages = [ pkgs.looking-glass-client ];

      # Virt Manager doesn't see ovmf
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

      environment.etc."libvirt/firmware/ovmf.json".text = ''
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

      systemd.units."libvirtd.service".wantedBy = lib.mkForce [ "multi-user.target" ];
    };
  };
}
