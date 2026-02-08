{ lib, config, ... }:
with lib;
{
  config = mkIf config.moduli.home-manager.kitty.enable {
    programs.kitty = {
      enable = true;
      shellIntegration.enableFishIntegration = true;
      enableGitIntegration = true;
      settings = {
        scrollback_lines = 10000;
        confirm_os_window_close = 0;
        enable_audio_bell = false;
        mouse_hide_wait = "0.5";
      };

      extraConfig = ''
        disable_ligatures never
        cursor_blink_interval 0
        cursor_trail 1
        background_opacity 0.75

        allow_remote_control yes
        listen_on unix:/tmp/mykitty
        action_alias kitty_scrollback_nvim kitten /nix/store/yi75szy270kvd2g975pzfdj841zh7bbf-mnw-configDir/pack/mnw/start/kitty-scrollback.nvim/python/kitty_scrollback_nvim.py
        map kitty_mod+h kitty_scrollback_nvim
        map kitty_mod+g kitty_scrollback_nvim --config ksb_builtin_last_cmd_output
        mouse_map ctrl+shift+right press ungrabbed combine : mouse_select_command_output : kitty_scrollback_nvim --config ksb_builtin_last_visited_cmd_output
      '';
    };
  };
}
