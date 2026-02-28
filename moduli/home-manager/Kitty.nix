{ lib, config, ... }:
with lib;
{
  config = mkIf config.moduli.home-manager.kitty.enable {
    programs.kitty = {
      enable = true;
      shellIntegration.enableFishIntegration = true;
      enableGitIntegration = true;
      settings = {
        font_family = "JetBrains Mono Nerd Font";
        font_size = 12;
        scrollback_lines = 10000;
        confirm_os_window_close = 0;
        enable_audio_bell = false;
        mouse_hide_wait = "0.5";
      };

      extraConfig = ''
        disable_ligatures never
        cursor_blink_interval 0
        cursor_trail 1

        map f1 create_marker
        map f2 remove_marker
        map ctrl+shift+n scroll_to_mark prev
        map ctrl+n scroll_to_mark next
      '';
    };
  };
}
