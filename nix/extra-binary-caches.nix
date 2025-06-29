{
  nix.settings = {
    trusted-users = [ "andme" ];

    builders-use-substitutes = true;
    extra-substituters = [
      "https://anyrun.cachix.org"
      "https://cache.garnix.io"
      "https://cache.nixos.org https://nixos-raspberrypi.cachix.org"
    ];

    extra-trusted-public-keys = [
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI="
    ];
  };
}
