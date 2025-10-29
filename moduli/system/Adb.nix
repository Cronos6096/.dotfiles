{pkgs, ...}:

{
  programs.adb.enable = true;
  users.users.andme.extraGroups = ["adbusers"];
    services.udev.packages = [
    # pkgs.android-udev-rules
  ];
}
