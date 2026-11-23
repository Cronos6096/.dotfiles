{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  kittyShell = pkgs.writeShellScript "kitty-zellij-shell" ''
    if [ -z "''${ZELLIJ:-}" ]; then
      exec ${getExe pkgs.zellij} attach --create main
    fi
    exec ${getExe pkgs.fish}
  '';
in
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
        shell = "${kittyShell}";
      };

      extraConfig = ''
        disable_ligatures never
        cursor_blink_interval 0
        cursor_trail 1
      '';
    };
  };
}
