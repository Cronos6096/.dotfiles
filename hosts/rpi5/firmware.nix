{ ... }:
{
  boot.loader.raspberry-pi.bootloader = "kernel";

  hardware.raspberry-pi.config.all."base-dt-params" = {
    pciex1 = {
      enable = true;
      value = "on";
    };
  };
}
