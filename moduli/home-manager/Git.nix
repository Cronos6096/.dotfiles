{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Cronos6096";
        email = "and.merciaro@gmail.com";
      };
      init.defaultBranch = "master";
      safe.directory = "/home/andme/.dotfiles";
    };
  };
}
