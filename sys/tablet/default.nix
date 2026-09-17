{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./gpu.nix
    ./options.nix
    ./plasma.nix
  ];

  boot.isContainer = true;

  networking.hostName = "tablet";
  networking.firewall.enable = false;
  time.timeZone = "Europe/Rome";

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";

  environment.systemPackages = with pkgs; [
    btop
    file
    yazi
  ];

  users = {
    users.andme = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      initialPassword = "";
      shell = pkgs.fish;

      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE0eWmYUr3u6FFhpv5Zj6LlcQIm8O4ZSJiZkuOtVM9NL andme@GiovanGianFranco"
      ];
    };
    users.root.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE0eWmYUr3u6FFhpv5Zj6LlcQIm8O4ZSJiZkuOtVM9NL andme@GiovanGianFranco"
    ];
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  programs.fish.enable = true;

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "prohibit-password";
  };

  stylix.enable = true;

  system.stateVersion = "26.05";
}
