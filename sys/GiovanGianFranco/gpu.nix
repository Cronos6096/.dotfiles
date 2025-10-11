{
  config,
  ...
}:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  boot.blacklistedKernelModules = [ "nouveau" ];
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    open = true;

    prime = {
      sync.enable = true;
      # integrated
      amdgpuBusId = "PCI:7:0:0";
      # dedicated
      nvidiaBusId = "PCI:1:0:0";
    };

    powerManagement = {
      enable = false;
      finegrained = false;
    };
  };
}
