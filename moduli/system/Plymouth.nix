{ inputs, ... }:
let
  pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };

  adiThemes = pkgs.adi1090x-plymouth-themes.override {
    selected_themes = [ "cubes" ];
  };
in
{
  boot = {
    plymouth.enable = true;
    plymouth.themePackages = [ adiThemes ];
    plymouth.theme = "cubes";
  };

  boot.kernelParams = [
    "quiet"
    "splash"
  ];
}
