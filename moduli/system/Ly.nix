{ pkgs, ... }:
{
  services.displayManager.ly = {
    enable = true;
    settings = {
      # none     -> Nothing
      # doom     -> PSX DOOM fire
      # matrix   -> CMatrix
      # colormix -> Color mixing shader
      # gameoflife -> John Conway's Game of Life
      animation = "none";

      # bigclock = "en";
      # asterisk = "·";
      # blankbox = "false";
      # # clock = "null";
    };
  };
  environment.systemPackages = [
    pkgs.brightnessctl
  ];
}
