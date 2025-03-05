{ pkgs, lib, ... }: {
  wayland.windowmanager.hyprland = {
    enable = true;
    settings = {
      # Set your theme.
      theme = "hyprland";
      # Set your wallpaper.
      wallpaper = "hyprland";
      # Set your font.
      font = "JetBrains Mono";
      # Set your terminal.
      terminal = "kitty";
      # Set your browser.
      browser = "floorp";
      # Set your editor.
      editor = "lvim";
    };
  };
}
