{
  pkgs,
  ...
}:
let
  mesaKgsl = pkgs.callPackage ../../modules/packages/mesa-android.nix { };
in
{
  hardware.graphics.enable = true;
  environment.systemPackages = with pkgs; [
    mesaKgsl
    glmark2
    mesa-demos
    vulkan-tools
    vulkan-loader
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    libdrm
    libxcb
    libX11
    wayland
    expat
    libxshmfence
  ];

  users = {
    groups.droidspaces-gpu = { };
    users.andme.extraGroups = [ "droidspaces-gpu" ];
    users.root.extraGroups = [ "droidspaces-gpu" ];
  };

  environment.sessionVariables = {
    MESA_LOADER_DRIVER_OVERRIDE = "kgsl";
    TU_DEBUG = "noconform";
    vblank_mode = "3";
    MESA_VK_WSI_PRESENT_MODE = "mailbox";
    VK_ICD_FILENAMES = "${mesaKgsl}/usr/share/vulkan/icd.d/freedreno_icd.aarch64.json";
    LIBGL_DRIVERS_PATH = "${mesaKgsl}/usr/lib/aarch64-linux-gnu/dri";
    LD_LIBRARY_PATH = "/run/current-system/sw/share/nix-ld/lib:${mesaKgsl}/usr/lib/aarch64-linux-gnu";
  };

  systemd.tmpfiles.rules = [
    "d /dev 0755 root root -"
    "c /dev/kgsl-3d0 246 0 0660 -"
  ];
}
