let
  shellAliases = {
    ls = "eza";
    ff = "fastfetch";
    rebuild = "nh os switch /home/andme/.dotfiles/ -H andme --update";
    rebuildnoup = "nh os switch /home/andme/.dotfiles/ -H andme";
    rebuildpush = " cdconf && git add * && git commit && git push && nh os switch . -H andme";
    clean = "nh clean all --keep=5";
    cat = "bat";
    cdconf = "cd /home/andme/.dotfiles";
    cdpr = "cd /home/andme/progetti";
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
    flake = "/home/andme/.dotfiles/";
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
