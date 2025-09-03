{ inputs, ... }:
{
  programs.anyrun = {
    enable = true;
    package = inputs.anyrun.packages.x86_64-linux.default;

    config = {
      plugins = with inputs.anyrun.packages.x86_64-linux; [
        applications
        shell
        randr
        kidex
        rink
        dictionary
        # symbols
      ];

      y.fraction = 0.3;
      hidePluginInfo = true;
      hideIcons = false;
      closeOnClick = true;
      maxEntries = null;
    };

    # extraCss = builtins.readFile (./. + "/style.css");
  };
}
