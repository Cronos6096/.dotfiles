{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  dotDir = ../../moduli/wm/hypr;
  cfgDir = "/home/andme/.config/hypr";

  collectFiles =
    dir: prefix:
    let
      dirStr = toString dir;
      entries = builtins.readDir dir;
      files = filterAttrs (_: type: type == "regular") entries;
      dirs = filterAttrs (_: type: type == "directory") entries;
      fileList = mapAttrsToList (name: _: {
        relPath = prefix + name;
        fullPath = "${dirStr}/${name}";
      }) files;
      dirList = flatten (
        mapAttrsToList (name: _: collectFiles "${dirStr}/${name}" "${prefix}${name}/") dirs
      );
    in
    fileList ++ dirList;

  allFiles = collectFiles dotDir "";
  hyprFiles = filter (f: f.relPath != "pyprland.toml") allFiles;
  hyprSymlinks = listToAttrs (
    map (f: {
      name = "${cfgDir}/${f.relPath}";
      value.source = mkForce (config.lib.file.mkOutOfStoreSymlink f.fullPath);
    }) hyprFiles
  );
in
{
  config = mkIf config.moduli.home-manager.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      portalPackage = null;
    };
    home = {
      file = hyprSymlinks // {
        "/home/andme/.config/pypr/config.toml".source = mkForce (
          config.lib.file.mkOutOfStoreSymlink "${toString dotDir}/pyprland.toml"
        );
      };
      packages = with pkgs; [
        wl-clipboard
        clipse
        hyprshot
        networkmanager
        hyprsome
        pyprland
        jq
        awww
        waypaper
        hyprmon
        bibata-cursors
        vicinae
      ];
    };
  };
}
