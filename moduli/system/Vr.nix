{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    alvr
    sidequest
  ];
}
