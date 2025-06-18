let
  shellAliases = {
    ls = "eza";
    ff = "fastfetch";
    rebuild = "nh os switch ~/.dotfiles/ -H GiovanGianFranco --update";
    rebuildpi = "nh os switch ~/.dotfiles/ -H GiovanGianFranco --update";
    rebuildnoup = "nh os switch ~/.dotfiles/ -H GiovanGianFranco";
    rebuildpush = " cdconf && git add * && git commit && git push && nh os switch . -H GiovanGianFranco";
    clean = "nh clean all --keep=5";
    cat = "bat";
    cdconf = "cd ~/.dotfiles";
    cdpr = "cd ~/progetti";
    v = "nvim";
    py = "python";
    py3 = "python3";
    nixsearch = "nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --scheme history";
  };
in
{
  # Nh
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 3d --keep 3";
    flake = "~/.dotfiles/";
  };

  programs.fish = {
    enable = true;
    inherit shellAliases;
    interactiveShellInit = ''
      set fish_greeting
    '';
  };

  programs.starship = {
    enableFishIntegration = true;
    enable = true;
  };
}
