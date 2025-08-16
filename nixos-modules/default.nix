{
  inputs,
  lib,
  modulesPath,
  pkgs,
  ...
}: {
  imports = [
    ./catppuccin.nix
    ./chaotic.nix
    ./mango.nix
    ./nh.nix
    ./openrgb.nix
    ./performance.nix
    ./scx.nix
    ./security.nix
    ./steam.nix
    ./uwsm.nix
    ../packages
  ];

  boot = {
    tmp.cleanOnBoot = true;
    kernelPackages = pkgs.linuxPackages_cachyos-lto;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "plymouth.use-simpledrm"
    ];
    loader = {
      timeout = 3;
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        consoleMode = "auto";
      };
    };
    plymouth = {enable = true;};
    initrd.systemd = {
      enable = true;
      settings.Manager = {
        DefaultTimeoutStartSec = "15s";
        DefaultTimeoutStopSec = "10s";
        DefaultLimitNOFILE = "2048:2097152";
      };
    };
  };

  catppuccin.plymouth.enable = true;

  networking = {
    hostFiles = [
      (pkgs.fetchurl {
        url = "https://hblock.molinero.dev/hosts";
        hash = "sha256-7i6KIWlTqdEGoyZfkYWjwugpWTiYlAgklcosrLVD31Q=";
      })
    ];
    networkmanager = {
      enable = true;
    };
  };

  time.timeZone = "America/Sao_Paulo";

  i18n.defaultLocale = "pt_BR.UTF-8";
  console = {
    font = "${pkgs.kbd}/share/consolefonts/Lat2-Terminus16.psfu.gz";
    # keyMap = "br";
    useXkbConfig = true; # use xkb.options in tty.
  };

  # Configure keymap in X11
  services = {
    xserver = {
      xkb.layout = "br";
      exportConfiguration = true;
    };
    gvfs.enable = true;
    upower.enable = true;
    gnome = {gnome-keyring.enable = true;};
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    fstrim = {
      enable = true;
      interval = "weekly"; # the default
    };
  };

  # nix configs
  nix = {
    gc = {
      automatic = false;
      dates = "weekly";
      options = "--delete-older-than 3d";
    };
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
      trusted-users = ["@wheel"];
      max-jobs = 12;
    };
  };

  nixpkgs.config.permittedInsecurePackages = ["mono-5.20.1.34"]; # Allow unfree
  nixpkgs.config.allowUnfree = true;
  # Nix
  documentation.nixos.enable = false;

  # Comment in installation, manually create a user
  users.users.miguel = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "video"];
    description = "Miguel";
  };

  environment.pathsToLink = ["/share/bash-completion"];

  environment.systemPackages = with pkgs; [git wl-clipboard];

  # Enable App Armor
  security.apparmor = {
    enable = true;
    killUnconfinedConfinables = true;
  };

  # Disable coredump
  systemd.coredump.enable = false;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  system.stateVersion = "23.11";
}
