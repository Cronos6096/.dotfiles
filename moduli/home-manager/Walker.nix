{
  programs.walker = {
    enable = true;
    runAsService = true;

    config = {
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
  };
}
