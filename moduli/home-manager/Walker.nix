{
  programs.walker = {
    enable = true;
    runAsService = true;

    config = {
      placeholders."default".input = "Example";
      providers.prefixes = [
        {
          provider = "websearch";
          prefix = "+";
        }
        {
          provider = "providerlist";
          prefix = "_";
        }
      ];
      keybinds.quick_activate = [
        "F1"
        "F2"
        "F3"
        "F4"
      ];
    };

    # # If this is not set the default styling is used.
    # theme.style = ''
    #   * {
    #     color: #dcd7ba;
    #   }
    # '';
  };
}
