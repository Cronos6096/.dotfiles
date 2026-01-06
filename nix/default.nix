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

  # boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
}
