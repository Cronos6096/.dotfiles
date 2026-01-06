{ pkgs, ... }:

{
  users.users.andme.extraGroups = [ "adbusers" ];
  services.udev.packages = [
    pkgs.android-tools
  ];
}
