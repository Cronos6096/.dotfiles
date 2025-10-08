{ config, ... }:
{
  sops = {
    defaultSopsFile = ./secrets.yaml;
    validateSopsFiles = false;

    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };

    secrets = {
      passwordAndme = { };
      openAiToken = {
        owner = config.users.users.andme.name;
        group = config.users.users.andme.group;
        path = "/run/secrets.d/openAiToken";
      };
      githubToken = {
        owner = config.users.users.andme.name;
        group = config.users.users.andme.group;
        path = "/run/secrets.d/githubToken";
      };
    };
  };
}
