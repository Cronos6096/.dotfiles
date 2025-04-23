{ pkgs, ... }:

{
  virtualisation.podman.enable = true;
  virtualisation.podman.dockerCompat = true; # Optional: makes it act like Docker

  environment.systemPackages = with pkgs; [
    podman
    distrobox
  ];
}
