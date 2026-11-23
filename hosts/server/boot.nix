{
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
    };

    supportedFilesystems = [ "btrfs" ];
    tmp.useTmpfs = true;
  };
}
