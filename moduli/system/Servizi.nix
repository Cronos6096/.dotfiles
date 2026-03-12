{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
{
  config = mkIf config.moduli.system.servizi.enable {

    nixpkgs.overlays = [
      (final: prev: {
        libratbag = prev.libratbag.overrideAttrs (oldAttrs: {
          version = "master-latest";

          src = pkgs.fetchFromGitHub {
            owner = "libratbag";
            repo = "libratbag";
            rev = "874c01732a7d3c074baefd8055c0d3efe8c9a935";
            sha256 = "sha256-O9DxwAieUEy+otwDSM2412vCCQJkHIrDOPVYevg0l44=";
          };

          postPatch = (oldAttrs.postPatch or "") + ''
            cat << 'EOF' > data/devices/logitech-g502-x-plus.device
            [Device]
            Name=Logitech G502 X PLUS
            DeviceMatch=usb:046d:c547;usb:046d:c095;046d:c548;usb:046d:4099
            DeviceType=mouse
            Driver=hidpp20

            [Driver/hidpp20]
            DeviceIndex=1
            Quirk=G502X_PLUS
            EOF
          '';
        });
      })
    ];

    services = {
      upower.enable = true;
      blueman.enable = true;
      libinput.enable = true;
      power-profiles-daemon.enable = true;

      openssh.enable = true;

      udisks2.enable = true;

      ratbagd = {
        enable = true;
      };
    };

    environment.systemPackages = [
      pkgs.piper
      pkgs.libratbag
    ];

    security.polkit.enable = true;

    # Kde connect
    programs.kdeconnect.enable = true;
    networking.firewall.allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    networking.firewall.allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
  };
}
