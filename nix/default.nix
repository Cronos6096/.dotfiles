{ pkgs, lib, ... }:
{
  imports = [ ./extra-binary-caches.nix ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    extra-platforms = [ "aarch64-linux" ];

    trusted-users = [
      "root"
      "@wheel"
    ];
  };

  boot.binfmt.emulatedSystems = lib.optionals (pkgs.stdenv.hostPlatform.system == "x86_64-linux") [
    "aarch64-linux"
  ];
}
