{ config, ... }:
let
  owner = config.users.users.andme.name;
  group = config.users.users.andme.group;
in
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
        inherit owner;
        inherit group;
        path = "/run/secrets.d/openAiToken";
      };
      githubToken = {
        inherit owner;
        inherit group;
        path = "/etc/nixos/secrets/githubToken";
      };
    };
  };
}
