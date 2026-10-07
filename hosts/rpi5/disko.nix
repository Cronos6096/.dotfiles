{ config, lib, ... }:

let
  firmwarePartition = {
    label = "FIRMWARE";
    priority = 1;

    type = "0700"; # Microsoft basic data
    attributes = [
      0 # Required Partition
    ];

    size = "512M";
    content = {
      type = "filesystem";
      format = "vfat";
      mountpoint = "/boot/firmware";
      mountOptions = [ "noatime" ];
    };
  };

  espPartition = {
    label = "ESP";

    type = "EF00"; # EFI System Partition (ESP)
    attributes = [
      2
    ];

    size = "100%";
    content = {
      type = "filesystem";
      format = "vfat";
      mountpoint = "/boot";
      mountOptions = [
        "noatime"
        "umask=0077"
      ];
    };
  };
in
{

  # https://nixos.wiki/wiki/Btrfs#Scrubbing
  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = [ "/" ];
  };

  fileSystems = {
    "/var/log".neededForBoot = true;
  };

  disko.devices.disk.sd = {
    type = "disk";
    device = "/dev/sda";
    imageSize = "9G";

    content = {
      type = "gpt";
      partitions = {
        FIRMWARE = firmwarePartition;
        ESP = espPartition;
      };
    };
  };

  disko.devices.disk.main = {
    type = "disk";
    device = "/dev/nvme0n1";

    content = {
      type = "gpt";
      partitions = {

        system = {
          type = "830C";

          size = "100%";
          content = {
            type = "btrfs";
            extraArgs = [
              "-f" # Override existing partition
            ];
            postCreateHook =
              let
                thisBtrfs = config.disko.devices.disk.main.content.partitions.system.content;
                device = thisBtrfs.device;
                subvolumes = thisBtrfs.subvolumes;

                makeBlankSnapshot =
                  btrfsMntPoint: subvol:
                  let
                    subvolAbsPath = lib.strings.normalizePath "${btrfsMntPoint}/${subvol.name}";
                    dst = "${subvolAbsPath}-blank";
                    #NOTE: this one-liner has the same functionality (inspired by zfs hook)
                    # btrfs subvolume list -s mnt/rootfs | grep -E ' rootfs-blank$' || btrfs subvolume snapshot -r mnt/rootfs mnt/rootfs-blank
                  in
                  ''
                    if ! btrfs subvolume show "${dst}" > /dev/null 2>&1; then
                      btrfs subvolume snapshot -r "${subvolAbsPath}" "${dst}"
                    fi
                  '';
              in
              ''
                MNTPOINT=$(mktemp -d)
                mount ${device} "$MNTPOINT" -o subvol=/
                trap 'umount $MNTPOINT; rm -rf $MNTPOINT' EXIT
                ${makeBlankSnapshot "$MNTPOINT" subvolumes."/rootfs"}
              '';
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
}
