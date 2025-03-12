{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./gpu.nix
    ./audio.nix
    moduli/Stylix.nix
    moduli/Vm.nix
    moduli/Hyprland.nix
    moduli/Ollama.nix
    moduli/Solaar.nix
  ];

  # Update automatici
  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "weekly";

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Swap
  swapDevices = [{
    device = "/swapfile";
    size = 30 * 1024; # 30GB
  }];

  # Hostname
  networking.hostName = "GiovanGianFranco";

  # Enable networking
  networking.networkmanager.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  # Kde
  #services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  programs.kdeconnect.enable = true;
  programs.partition-manager.enable = true;

  # Stylix
  stylix.enable = true;

  # Ly
  services.displayManager.ly.enable = true;

  # Keymap
  console.keyMap = "it";
  services.xserver.xkb.layout = "it";

  i18n.defaultLocale = "it_IT.UTF-8";

  i18n.extraLocaleSettings = {
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

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Account
  users.users.andme = {
    isNormalUser = true;
    description = "Andrei Merciaro";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    home = "/home/andme";
  };

  users.groups.gcis = { };
  users.users.gcis = {
    isSystemUser = true;
    group = "gcis";
  };

  # zsh shell
  programs.zsh.enable = true;

  # Abilita pacchetti unfree/Flake
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    anydesk
    appimage-run
    clamtk
    floorp
    fzf
    git
    home-manager
    hyprpanel
    libratbag
    libreoffice
    libva
    libva-utils
    logitech-udev-rules
    mangohud
    mesa
    nil
    nix-output-monitor
    nixfmt-classic
    nvd
    nvtopPackages.nvidia
    piper
    prismlauncher
    qalculate-gtk
    tldr
    vscode
    vulkan-extension-layer
    vulkan-loader
    vulkan-tools
    vulkan-validation-layers
    wget
    winetricks
    wineWowPackages.waylandFull

    # Rust
    cargo
    clippy
    rustc
    rustfmt
    gcc
  ];

  # Steam
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  # Servizi
  # OpenSSH daemon.
  services.openssh.enable = true;

  # Flatpak
  services.flatpak.enable = true;

  # services.ratbagd.enable = true;

  system.stateVersion = "25.05";
}
