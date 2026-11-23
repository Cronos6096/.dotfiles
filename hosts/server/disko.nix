let
  mainDisk = "/dev/nvme0n1";
  dataDisk = "/dev/nvme1n1";
in
{
  disko.devices.disk = {
    main = {
      type = "disk";
      device = mainDisk;
      content = {
        type = "gpt";
        partitions = {
          boot = {
            size = "1G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ];
            };
          };

          root = {
            size = "100%";
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ];
              subvolumes = {
                "/rootfs" = {
                  mountpoint = "/";
                  mountOptions = [ "noatime" ];
                };

                "/nix" = {
                  mountpoint = "/nix";
                  mountOptions = [ "noatime" ];
                };

                "/log" = {
                  mountpoint = "/var/log";
                  mountOptions = [ "noatime" ];
                };
              };
            };
          };
        };
      };
    };

    data = {
      type = "disk";
      device = dataDisk;
      content = {
        type = "gpt";
        partitions = {
          data = {
            size = "100%";
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ];
              subvolumes = {
                "/data" = {
                  mountpoint = "/data";
                  mountOptions = [ "noatime" ];
                };
              };
            };
          };
        };
      };
    };
  };

  fileSystems."/var/log".neededForBoot = true;

  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = [
      "/"
      "/data"
    ];
  };
}
