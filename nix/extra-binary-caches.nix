{
  nix.settings = {
    trusted-users = [ "andme" ];

    substituters = [ "https://nix-gaming.cachix.org" ];
    trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
    ];

    builders-use-substitutes = true;
    extra-substituters = [
      # "https://walker.cachix.org"
      "https://cache.garnix.io"
      "https://cache.nixos.org https://nixos-raspberrypi.cachix.org"
    ];

    extra-trusted-public-keys = [
      # "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI="
    ];
  };
}
