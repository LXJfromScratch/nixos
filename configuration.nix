# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports =
    [
    ./hardware-configuration.nix
      <home-manager/nixos>
    ];

# Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config.allowUnfree = true;

# networking.hostName = "nixos"; # Define your hostname.
# Pick only one of the below networking options.
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
# networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

# Set your time zone.
  time.timeZone = "Asia/Shanghai";

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
  networking.proxy.default = "http://192.168.31.182:7890/";
  networking.proxy.noProxy = "127.0.0.1,localhost";

# Select internationalisation properties.
# i18n.defaultLocale = "en_US.UTF-8";
# console = {
#   font = "Lat2-Terminus16";
#   keyMap = "us";
#   useXkbConfig = true; # use xkbOptions in tty.
# };

   i18n.inputMethod = {
     enabled = "fcitx5";
     fcitx5.addons = with pkgs; [
       fcitx5-chinese-addons
       fcitx5-table-extra
       fcitx5-gtk
       fcitx5-configtool
     ];
   };

  #nix.settings.substituters = ["https://mirror.sjtu.edu.cn/nix-channels/store"];

  services = {
# Enable the X11 windowing system.
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      layout = "us";
#xkbOptions = "eurosign:e,caps:escape";
      videoDrivers = ["nvidia" "modesetting"];
      libinput = {
        enable = true;
        touchpad = {
          tapping = true;
        };
      };
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    blueman.enable = true;
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = true;
      };
    };
    printing.enable = false; # Enable CUPS to print documents.
  };

# Enable sound.
  sound.enable = true;

# Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lxj = {
    isNormalUser = true;
    extraGroups = [ "wheel" "sudo" "video" "audio" "input" "docker" ]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [
      ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      lxj = import ./users/lxj.nix;
      root = import ./users/root.nix;
    };
  };

# List packages installed in system profile. To search, run:
# $ nix search wget

  environment = {
    systemPackages = (with pkgs; [
        wget
        gcc
        fzf
        nodejs
        unzip
        cmake
        gnumake
        kdenlive
        kate
        obsidian
#neovim
        qq
        firefox
        libreoffice
        gparted
        clash-verge
        alacritty
        pciutils # for lspci command
        numix-icon-theme-circle
        gnome3.gnome-tweaks
    ]) ++ (with pkgs.gnomeExtensions; [
        appindicator
    ]);
    variables = {
      EDITOR = "nvim";
    };
    gnome = {
      excludePackages = (with pkgs; [
          gnome-tour
          gnome-user-docs
      ]) ++ (with pkgs.gnome; [
        gedit # text editor
        epiphany # web browser
        geary # email reader
        evince # document viewer
        gnome-characters
        gnome-weather
        totem # video player
        tali # poker game
        iagno # go game
        hitori # sudoku game
        atomix # puzzle game
        yelp
      ]);
    };
  };

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };


# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

# Copy the NixOS configuration file and link it from the resulting system
# (/run/current-system/configuration.nix). This is useful in case you
# accidentally delete configuration.nix.
# system.copySystemConfiguration = true;

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It's perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}

