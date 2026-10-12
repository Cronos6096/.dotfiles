{
  nix.settings = {
    builders-use-substitutes = true;

    extra-substituters = [
      "https://cache.nixos.org"
      "https://hyprland.cachix.org"
      "https://noctalia.cachix.org"
      "https://nixos-raspberrypi.cachix.org"
      "https://system.cachix.org"
    ];

    extra-trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI="
      "system.cachix.org-1:F8Q6CP+ye/x4wzpCziyJrMw90Sjd1EATiR9DLJK9aco="
    ];
  };
}
