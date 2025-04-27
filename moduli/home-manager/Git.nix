{
  programs.git = {
    enable = true;
    userName = "Cronos6096";
    userEmail = "and.merciaro@gmail.com";
    extraConfig = {
      init.defaultBranch = "master";
      safe.directory = "/home/andme/.dotfiles";
    };
  };
}
