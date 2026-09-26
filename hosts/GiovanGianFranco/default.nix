{
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./gpu.nix
    ./gpu-passthrough.nix
    ./audio.nix
    ./options.nix
    ./system-packages.nix
  ];

  networking = {
    hostName = "GiovanGianFranco";
    networkmanager.enable = true;
  };

  hardware.bluetooth.enable = true;

  # HACK: https://github.com/NixOS/nixpkgs/issues/409986
  environment.etc."xdg/menus/applications.menu".source = pkgs.runCommand "applications.menu" { } ''
    cp ${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu $out
  '';

  # Needed by the libvirt guest account declared in modules/system/Vm.nix.
  users = {
    groups.gcis = { };
    users.gcis = {
      isSystemUser = true;
      group = "gcis";
    };

    users.andme.extraGroups = [
      "networkmanager"
      "libvirtd"
      "dialout"
      "kvm"
    ];
  };

  system.stateVersion = "25.11";
}
