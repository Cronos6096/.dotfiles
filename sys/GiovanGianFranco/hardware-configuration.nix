{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "usbhid"
    "usb_storage"
    "sd_mod"
    "sdhci_pci"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  # Swap
  swapDevices = [
    {
      device = "/swapfile";
      size = 32 * 1024;
    }
  ];

  hardware.bluetooth.package = pkgs.bluez-experimental;

  # Kernel
  boot.kernel.sysctl = {
    "vm.max_map_count" = 16777216;
    "fs.file-max" = 524288;
  };
  boot.loader.timeout = 0;

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/b93d1662-1ce3-4bf0-ac5d-25998cb4b0ec";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-26655e7b-78c1-47bb-b42f-e9ecf53f7a28".device =
    "/dev/disk/by-uuid/26655e7b-78c1-47bb-b42f-e9ecf53f7a28";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/F7D6-6DF6";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
