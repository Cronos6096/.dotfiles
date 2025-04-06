{
  config,
  pkgs,
  inputs,
  ...
}: let
  pkgs-unstable =
    inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    package = pkgs-unstable.mesa;
    package32 = pkgs-unstable.pkgsi686Linux.mesa;
  };

  hardware.nvidia.prime = {
    sync.enable = true;

    # integrated
    amdgpuBusId = "PCI:7:0:0";
    # dedicated
    nvidiaBusId = "PCI:1:0:0";
  };

  boot.blacklistedKernelModules = ["nouveau"];

  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    open = true;
    powerManagement.finegrained = false;
    powerManagement.enable = false;
  };

  # Xorg
  services.xserver.enable = true;
  services.xserver.autorun = true;
}
