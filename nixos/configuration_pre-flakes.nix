# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(4) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Lisbon";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_PT.UTF-8";
    LC_IDENTIFICATION = "pt_PT.UTF-8";
    LC_MEASUREMENT = "pt_PT.UTF-8";
    LC_MONETARY = "pt_PT.UTF-8";
    LC_NAME = "pt_PT.UTF-8";
    LC_NUMERIC = "pt_PT.UTF-8";
    LC_PAPER = "pt_PT.UTF-8";
    LC_TELEPHONE = "pt_PT.UTF-8";
    LC_TIME = "pt_PT.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Graphics
  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
    graphics.enable = true;
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;  # Enable if applications keep crashing on resume. Sleep might fail though.
      powerManagement.finegrained = false;
      open = true; # open-source kernel MODULE, not to be confused with the independent noveau DRIVER. Should be true.
      nvidiaSettings = true;
      # package = config.boot.kernelPackages.nvidiaPackages.stable; # doesn't compile with open = true
      package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
          version = "580.65.06";
          sha256_64bit = "sha256-BLEIZ69YXnZc+/3POe1fS9ESN1vrqwFy6qGHxqpQJP8=";
          openSha256 = "sha256-BKe6LQ1ZSrHUOSoV6UCksUE0+TIa0WcCHZv4lagfIgA=";
          settingsSha256 = "sha256-9PWmj9qG/Ms8Ol5vLQD3Dlhuw4iaFtVHNC0hSyMCU24=";
          usePersistenced = false;
      };
    };

    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;  # to show battery
          FastConnectable = true;  # Devices can connect faster to us
        };
        Policy = {
          AutoEnable = true;  # Enable all controllers when they are found
        };
      };
    };
  };
  
  services.blueman.enable = false;  # Reenable if switching out of KDE or Gnome 3

  services.displayManager = {
    enable = true;
    
    # for KDE
    sddm = {
      enable = true;
      wayland.enable = true;
      autoNumlock = true;
    };

    # without KDE
    # ly.enable = true;
  };

  # Enable KDE!
  services.desktopManager.plasma6.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.diogo = {
    isNormalUser = true;
    description = "Diogo Marques";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;

    # -----------
    # My programs
    # -----------

    packages = with pkgs; [
    
      # Terminal
      alacritty
      ghostty
      wezterm

      # Terminal utilities for using linux
      bluetuith
      ffmpeg-full
      microfetch
      ncpamixer
      ranger

      # Terminal utilities for dev stuff
      fzf
      gh
      jq
      jqp # TUI playground to experiment with jq
      jujutsu
      mise
      watchexec
      zola

      # for specific projects
      # (to be moved to a nix file when I learn to write those)
      # sdcc

      # RIIR
      atuin
      bat
      bottom  # htop in Rust
      delta
      dfc
      difftastic
      dust
      eza
      fd
      hexyl
      hyperfine
      igrep
      jless
      md-tui
      nushell
      procs
      ripgrep
      sd
      skim  # fzf in Rust
      tealdeer
      tokei

      # More cool utilites
      mpv

      # KDE
      kdePackages.discover
      kdePackages.kcalc
      kdePackages.kcharselect
      kdePackages.kclock
      kdePackages.kcolorchooser
      kdePackages.kolourpaint
      kdePackages.ksystemlog
      kdePackages.sddm-kcm
      kdePackages.isoimagewriter
      kdePackages.partitionmanager
      kdiff3
      twilight-kde

      # Browsers
      firefox

      # Chat
      discord
      telegram-desktop

      # Code editors
      vscode.fhs # vscodium.fhs 

      # Art / Game dev
      aseprite
      blender
      gimp3 # -with-plugins ??
      krita
      krita-plugin-gmic
      godotPackages_4_5.export-templates-bin
      godotPackages_4_5.godot

      # Desktop utilities
      ddcui
      ddcutil
      hardinfo2
      pasystray
      pavucontrol
      piper

      # Wayland
      fuzzel
      gammastep
      mako
      swaybg
      swayidle
      swaylock
      waybar
      wayland-utils
      wireplumber
      wl-clipboard
      wlsunset
      xwayland-satellite

      # Gaming
      prismlauncher  # Minecraft

    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
   neovim
   git
   tmux
   w3m
   htop
   nautilus
   killall

   # Nicer nix
   nix-output-monitor
   nox
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  programs = {
    niri.enable = true;
    waybar.enable = false; # I'll launch it in Niri config
    fish.enable = true;
    starship = {
        enable = true;
        transientPrompt = {
            enable = true;
            # left = "starship module character"
            # right = "starship module time"
        };
        settings = {};
    };
    yazi = {
        enable = true;
        settings = {};
    };
    zoxide = {
        enable = true;
        enableBashIntegration = true;
        enableFishIntegration = true;
    };
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    source-code-pro
    nerd-fonts.iosevka
    nerd-fonts.terminess-ttf
    nerd-fonts.meslo-lg
    nerd-fonts.hack
    nerd-fonts.inconsolata
    nerd-fonts.fira-code
  ];

services.ratbagd.enable = true;

services.ddccontrol.enable = true;

services.pipewire = {
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
  # jack.enable = true; # If you want to use JACK applications, uncomment this
  # extraConfig = ...   # can be used to create drop-in configuration files, if needed
  # wireplumber.extraConfig...  # to configure WirePlumber directly
};

security.rtkit.enable = true;  # recomended in PipeWire wiki page

security.polkit.enable = true; # polkit
services.gnome = {
  gnome-keyring.enable = true; # secret service
  sushi.enable = true;
};
security.pam.services.swaylock = {};


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

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # --------------------
  # Nix / NixOS settings
  # --------------------
  nix.settings.experimental-features = [
      "nix-command" "flakes"
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
