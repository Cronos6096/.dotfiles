{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./gpu.nix
    ./audio.nix
    moduli/Hyprland.nix
    moduli/Lingua.nix
    moduli/Ollama.nix
    moduli/Python.nix
    moduli/Servizi.nix
    moduli/Solaar.nix
    moduli/Stylix.nix
    moduli/Vm.nix
    # moduli/Piper.nix
  ];

  # Update automatici
  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "weekly";

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Swap
  swapDevices = [
    {
      device = "/swapfile";
      size = 30 * 1024; # 30GB
    }
  ];

  # Hostname
  networking.hostName = "GiovanGianFranco";

  # Rete
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Stylix
  stylix.enable = true;

  # Ly
  services.displayManager.ly.enable = true;

  # Account
  users.users.andme = {
    isNormalUser = true;
    description = "Andrei Merciaro";
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
    ];
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
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.systemPackages = with pkgs; [
    nixfmt-rfc-style
    anydesk
    appimage-run
    clamtk
    floorp
    fzf
    git
    home-manager
    hyprpanel
    libreoffice
    libva
    libva-utils
    logitech-udev-rules
    mesa
    nil
    nix-output-monitor
    nvd
    nvtopPackages.nvidia
    orca-slicer
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
  ];

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  system.stateVersion = "25.05";
}
