{
  imports = [ ./BinaryCaches.nix ];

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    extra-platforms = [ "aarch64-linux" ];

    trusted-users = [ "@wheel" ];
  };
}
