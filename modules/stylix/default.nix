{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/evenok-dark.yaml";

    image = ../wallpaper.png;
    polarity = "dark";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 18;
    };

    autoEnable = true;

    opacity = {
      terminal = 0.75;
      desktop = 0.75;
    };

    fonts = {
      serif = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Mono Nerd Font";
      };

      sansSerif = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Mono Nerd Font";
      };

      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Mono Nerd Font";
      };

      emoji = {
        package = pkgs.nerd-fonts.symbols-only;
        name = "Symbols Nerd Font";
      };
    };
  };

  home-manager.users.andme.stylix.targets = {
    zen-browser.enable = mkIf config.home-manager.users.andme.moduli.home-manager.zen.enable false;
    noctalia-shell.enable = mkIf config.home-manager.users.andme.moduli.home-manager.noctalia.enable true;
  };

  environment.systemPackages = [ pkgs.bibata-cursors ];
}
