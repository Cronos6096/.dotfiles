{
  pkgs,
  ...
}:
{
  imports = [
    ./home-options.nix
    ./home-packages.nix
  ];

  home.sessionVariables = {
    BROWSER = "zen";
    TERMINAL = "kitty";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_CACHE_HOME = "\${HOME}/.cache";
    XDG_CONFIG_HOME = "\${HOME}/.config";
    XDG_BIN_HOME = "\${HOME}/.local/bin";
  };

  # stylix palette is host-specific
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/evenok-dark.yaml";

  # VR
  xdg.configFile."openxr/1/active_runtime.json".source =
    "${pkgs.wivrn}/share/openxr/1/openxr_wivrn.json";
}
