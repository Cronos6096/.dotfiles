{
  nix.settings = {
    trusted-users = [ "andme" ];

    builders-use-substitutes = true;
    extra-substituters = [
      "https://cache.nixos.org"
      "https://cuda-maintainers.cachix.org"
      "https://hyprland.cachix.org"
      "https://noctalia.cachix.org"
      "https://system.cachix.org"
    ];

    extra-trusted-public-keys = [
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      "system.cachix.org-1:F8Q6CP+ye/x4wzpCziyJrMw90Sjd1EATiR9DLJK9aco="
    ];
  };
}
