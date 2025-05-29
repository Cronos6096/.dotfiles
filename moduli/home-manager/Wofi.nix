let
  css = ''
    window {
      background: #272822;
      color:      #383830;
      border-radius: 4px;
    }

    button.selected {
      background: #a6e22e;
      color:      #fb4934;
    }
  '';
in{
  programs.wofi.enable = true;
  programs.wofi.settings = {
    show-icons = true;
    case-sensitive = true;
    show-keys = false;
  };
}
