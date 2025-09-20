{ inputs, ... }:
{
  programs.anyrun = {
    enable = true;
    package = inputs.anyrun.packages.x86_64-linux.default;

    config = {
      plugins = with inputs.anyrun.packages.x86_64-linux; [
        applications
        kidex
        rink
        dictionary
        symbols
      ];

      hidePluginInfo = true;
      hideIcons = false;
      closeOnClick = true;
      maxEntries = null;
      showResultsImmediately = false;
    };

    # extraCss = builtins.readFile (./. + "/style.css");
  };
}
