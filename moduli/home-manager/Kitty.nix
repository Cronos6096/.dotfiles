{
  # Terminale
  programs.kitty = {
    enable = true;
    # shellIntegration.enableZshIntegration = true;
    shellIntegration.enableFishIntegration = true;
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
      background_opacity 0.9
    '';
  };
}
