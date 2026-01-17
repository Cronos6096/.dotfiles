{ lib, config, ... }:
with lib;
{
  config = mkIf config.moduli.system.lingua.enable {
    console.keyMap = "us";

    i18n.defaultLocale = "en_US.UTF-8";

    services.xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "intl";
      };
    };

    time.timeZone = "Europe/Rome";

    i18n.extraLocaleSettings = {
      LANGUAGE = "en_US.UTF-8";
      LC_ADDRESS = "it_IT.UTF-8";
      LC_IDENTIFICATION = "it_IT.UTF-8";
      LC_MEASUREMENT = "it_IT.UTF-8";
      LC_MONETARY = "it_IT.UTF-8";
      LC_NAME = "it_IT.UTF-8";
      LC_NUMERIC = "it_IT.UTF-8";
      LC_PAPER = "it_IT.UTF-8";
      LC_TELEPHONE = "it_IT.UTF-8";
      LC_TIME = "it_IT.UTF-8";
    };
  };
}
