# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec -a "$0" "$@"
  '';
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./home-manager.nix
      ./blurlock.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # Add ZFS support.
  boot.supportedFilesystems = ["zfs"];

  # ZRam for more memory.
  zramSwap = {
    enable = true;
    memoryPercent = 150;
  };

  networking = {
    hostName = "NotTim"; # Define your hostname.
    hostId = "43048d3c";
    wireless = {
      enable = true;  # Enables wireless support via wpa_supplicant.
      networks = {
        Sunshine4echo = {
          pskRaw = "a15099af45fd8e63d914897684d4ff27b8ea2132495855a28bbc4723a096ebcf";
        };
        GoneCamping = {
          pskRaw = "57ab66186f55dccd2fa86e377ece0373c4ddd30efb17787059796f7ff530f590";
        };
        At_home = {
          pskRaw = "6a3dff0ef816b57f1195972527deb5d64e124e161be291c4d8676ed79264fdb6";
        };
        At_home_5GHz = {
          pskRaw = "8b1e72bc0656b7c119c3a2288e372876b65d867fffda5c069a6b8bf3284e733b";
        };
      };
    };
    nameservers = [ "8.8.8.8" "8.8.4.4" "208.67.222.222" "208.67.220.220" ];

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    interfaces.enp2s0.useDHCP = true;
    interfaces.wlp3s0.useDHCP = true;

    # Open ports in the firewall.
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    firewall = {
      enable = true;
      allowPing = true;
    };
  };

  # Set your time zone.
  time.timeZone = "US/Pacific";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "colemak";
  };

  # Enable the Plasma 5 Desktop Environment.
  services.xserver = {
    enable = true;
    desktopManager.xterm.enable = false;
    windowManager.i3.enable = true;
    # Configure keymap in X11
    layout = "us";
    xkbVariant = "colemak";
    # Enable touchpad support (enabled default in most desktopManager).
    libinput = {
      enable = true;
      disableWhileTyping = true;
      naturalScrolling = true;
      additionalOptions = ''
        Option "PalmDetection" "True"
      '';
    };
    videoDrivers = [ "nvidia" ];
  };
  
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Tlp power managment
  services.tlp.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
  #  extraModules = [ pkgs.pulseaudio-modules-bt ];
    package = pkgs.pulseaudioFull;
  #  configFile = pkgs.writeText "default.pa" ''
  #    load-module module-bluetooth-policy
  #    load-module module-bluetooth-discover
      ## module fails to load with 
      ##   module-bluez5-device.c: Failed to get device path from module arguments
      ##   module.c: Failed to load module "module-bluez5-device" (argument: ""): initialization failed.
      # load-module module-bluez5-device
      # load-module module-bluez5-discover
  #  '';
  #  extraConfig = "
  #    load-module module-switch-on-connect
  #  ";
  };

  # Enable bluetooth.
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Nvidia drivers.
  hardware.nvidia.prime = {
    offload.enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    mutableUsers = false;
    users.bren077s = {
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [ "wheel" "video" "audio" "disk" "network-manager" ];
      hashedPassword = "$6$43WewimBbBQLy$ZaxEe5tJfF24uk8czcI91M9yd0vLfIhgHlC2rvpS2VBbeDdr7.mOTPLEPV8HhrlizScjsmy5FLg.J3pWWYrsy1";
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    coreutils
    gitAndTools.gitFull
    man
    tree
    wget
    mkpasswd
    bluez
    bluez-tools
    lxappearance
    lsof
    libnotify
    xdotool
    xorg.xkill
    xfce.xfce4-power-manager
    xautolock

    caffeine-ng
    htop
    powertop
    iotop
    vim
    ripgrep
    pavucontrol
    pa_applet
    nvidia-offload

    pcmanfm
    firefox
    google-chrome
  ];

  fonts.fonts = with pkgs; [
    fira
    fira-code
    powerline-fonts
  ];

  environment.sessionVariables = {
    TERMINAL = ["alacritty"];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs.dconf.enable = true;
  programs.zsh.enable = true;

  # Enable lorri for development.
  services.lorri.enable = true;
  
  # ZFS services
  services.zfs.autoSnapshot.enable = true;
  services.zfs.autoScrub.enable = true;

  # Nix gc.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}

