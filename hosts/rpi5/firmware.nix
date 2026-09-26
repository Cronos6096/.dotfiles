{
  ...
}:
{
  hardware.raspberry-pi = {
    firmware = {
      enable = true;
      uboot.enable = true;
    };
    configtxt.settings = {
      all = {
        dtparam = [
          "pciex1"
          "pciex1_gen=3"
        ];
      };
    };
  };
}
