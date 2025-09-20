{ pkgs, ... }:
let
  shellAliases = {
    ls = "eza";
    ff = "fastfetch";
    rebuild = "nh os switch ~/.dotfiles/ -H GiovanGianFranco --update";
    rebuildpi = "nh os switch ~/.dotfiles/ -H GiovanGianFranco --update";
    rebuildnoup = "nh os switch ~/.dotfiles/ -H GiovanGianFranco";
    rebuildpush = " cdconf && git add * && git commit && git push && nh os switch . -H GiovanGianFranco";
    clean = "nh clean all";
    cdconf = "cd ~/.dotfiles";
    cdpr = "cd ~/progetti";
    v = "nvim";
    py = "python";
    py3 = "python3";
    nixsearch = "nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --scheme history";
    gas = "git add * && git stage *";

    cat = "bat";
    find = "fd";
    grep = "rg";
    tree = "eza --git --icons --tree";
  };
in
{
  programs = {
    # Nh
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 3d --keep 3";
      flake = "~/.dotfiles/";
    };

    fish = {
      enable = true;
      inherit shellAliases;
      interactiveShellInit = ''
        set fish_greeting
      '';
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    starship = {
      enableFishIntegration = true;
      enable = true;
    };

    tmux = {
      enable = true;
      sensibleOnTop = true;
      shortcut = "a";
      clock24 = true;
      baseIndex = 1;
      focusEvents = true;

      plugins = with pkgs.tmuxPlugins; [
        continuum
        resurrect
        sensible
        tmux-which-key
        yank
        urlview
      ];
    };
  };
}
