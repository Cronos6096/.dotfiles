# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # # Update automatici
  # system.autoUpgrade.enable = true;
  # system.autoUpgrade.dates = "weekly";
  # nix.gc.automatic = true;
  # nix.gc.dates = "daily";
  # nix.gc.options = "--delete-older-than 3d";
  # nix.settings.auto-optimise-store = true;

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Swap
  swapDevices = [{
    device = "/swapfile";
    size = 30 * 1024; # 30GB
  }];

  networking.hostName = "GiovanGianFranco"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  # Select internationalisation properties.
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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Gpu
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia.prime = {
    sync.enable = true;

    # integrated
    amdgpuBusId = "PCI:7:0:0";
    # dedicated
    nvidiaBusId = "PCI:1:0:0";
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    open = true;
    powerManagement.finegrained = false;
    powerManagement.enable = false;
  };

  # Kde
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  programs.kdeconnect.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "it";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "it2";
  console.font = "nerd-fonts.zed-mono"; 
  
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.andme = {
    isNormalUser = true;
    description = "Andrei Merciaro";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    home = "/home/andme";
  };

  # zsh shell
  programs.zsh.enable = true;

  # Allow unfree packages/Flake
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  programs.partition-manager.enable = true;

  environment.systemPackages = with pkgs; [
    appimage-run
    clamtk
    floorp
    fzf
    git
    libratbag
    libreoffice
    libva
    libva-utils
    mangohud
    mesa
    nix-output-monitor
    nvd
    nvtopPackages.nvidia
    orca-slicer
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
    home-manager
    nixfmt-classic
    nil
    logitech-udev-rules
    quickemu
    qemu
  ];

  # Steam
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  # Solarr
  services.solaar = {
    enable = true; # Enable the service
    package = pkgs.solaar; # The package to use
    window =
      "hide"; # Show the window on startup (show, *hide*, only [window only])
    batteryIcons =
      "regular"; # Which battery icons to use (*regular*, symbolic, solaar)
    extraArgs = ""; # Extra arguments to pass to solaar on startup
  };

  # Virt Manager
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["andme"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  # # Abilita il servizio ratbagd
  # services.ratbagd.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Flatpak
  services.flatpak.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "25.05";
}
