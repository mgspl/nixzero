{
  inputs,
  lib,
  modulesPath,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./catppuccin.nix
    ./chaotic.nix
    ./fonts.nix
    ./gaming.nix
    ./gsr.nix
    ./graphicsAmd.nix
    #./lanzaboote.nix
    ./lix.nix
    ./niri.nix
    ./nh.nix
    ./openrgb.nix
    ./performance.nix
    ./security.nix
    ./tuned.nix
  ];

  boot = {
    tmp.cleanOnBoot = true;
    kernelPackages = pkgs.linuxPackages_cachyos-lto;
    #extraModulePackages = with config.boot.kernelPackages; [zenpower];
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "plymouth.use-simpledrm"
      "amd_pstate=active"
      "nosplit_lock_mitigate"
    ];
    loader = {
      timeout = 0;
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
        hash = "sha256-U6N1el1oejYNMJI1A507KqsuNNcL7B8KTL6/VVQr4aI=";
      })
    ];
    networkmanager = {
      enable = true;
    };
  };

  virtualisation.docker = {
    enable = true;
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
    #flatpak.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      extraConfig.pipewire."92-low-latency" = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.quantum" = 256;
          "default.clock.min-quantum" = 256;
          "default.clock.max-quantum" = 256;
        };
      };
      wireplumber.extraConfig = {
        "10-disable-camera" = {
          "wireplumber.profiles" = {
            main = {
              "monitor.libcamera" = "disabled";
            };
          };
        };
      };
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
      #max-jobs = 1;
    };
  };

  programs.dconf.enable = true;

  nixpkgs = {
    config = {
      permittedInsecurePackages = ["mono-5.20.1.34" "mbedtls-2.28.10"];
      allowUnfree = true;
    };
    overlays = [
      inputs.niri.overlays.niri
      (import ../packages/overlay.nix)
    ];
  };
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

  programs.coolercontrol.enable = true;

  # Disable coredump
  systemd.coredump.enable = false;

  system.stateVersion = "23.11";
}
