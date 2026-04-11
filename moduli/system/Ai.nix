{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
{

  config = mkIf config.moduli.system.Ai.enable {
    services.ollama = {
      enable = true;
      package = pkgs.ollama-cuda;
    };

    environment.systemPackages = with pkgs; [
      lmstudio
    ];

    users.users.andme.extraGroups = [ "hermes" ];

    services.hermes-agent = {
      enable = true;
      user = "andme";
      group = "users";
      createUser = false;
      addToSystemPackages = true;
      documents = {
        "SOUL.md" = "~/.hermes/SOUL.md";
        "USER.md" = "~/.hermes/USER.md";
      };
      container = {
        enable = true;
        backend = "docker";
        extraVolumes = [
          "/home/andme/progetti:/projects:rw"
          "/home/andme/.dotfiles:/dotfiles:rw"
        ];
      };
      settings = {
        toolsets = [ "all" ];
        memory = {
          memory_enabled = true;
          user_profile_enabled = true;
        };
        display = {
          bell = true;
        };
        model = {
          provider = "custom";
          base_url = "http://localhost:1234/v1";
          default = "qwen3.5-9b-uncensored";
        };
      };
    };
  };
}
