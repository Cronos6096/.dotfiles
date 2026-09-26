{
  config,
  pkgs,
  ...
}:
{
  users = {
    mutableUsers = false;

    users.andme = {
      isNormalUser = true;
      home = "/home/andme";
      shell = pkgs.fish;
      extraGroups = [ "wheel" ];
      hashedPasswordFile = config.age.secrets.password.path;
    };
  };

  programs.fish.enable = true;
}
