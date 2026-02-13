{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  ly = pkgs.ly.overrideAttrs (oldAttrs: {
    postPatch = "";
    postConfigure = ''
      export ZIG_GLOBAL_CACHE_DIR="$TMPDIR"
      ln -s "${
        pkgs.callPackage (pkgs.path + "/pkgs/by-name/ly/ly/deps.nix") {
          zig = pkgs.zig_0_15;
        }
      }" "$ZIG_GLOBAL_CACHE_DIR/p"
    '';
  });
in
{
  config = mkIf config.moduli.system.ly.enable {
    services.displayManager.ly = {
      enable = true;
      package = ly;
      # settings = {
      #   # none     -> Nothing
      #   # doom     -> PSX DOOM fire
      #   # matrix   -> CMatrix
      #   # colormix -> Color mixing shader
      #   # gameoflife -> John Conway's Game of Life
      #   animation = "none";
      #
      #   # bigclock = "en";
      #   # asterisk = "·";
      #   # blankbox = "false";
      #   # # clock = "null";
      # };
    };
    environment.systemPackages = [
      pkgs.brightnessctl
    ];
  };
}
