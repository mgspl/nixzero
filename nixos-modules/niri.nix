{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.niri.nixosModules.niri
    inputs.dankMaterialShell.nixosModules.greeter
  ];

  # # Enable SDDM
  # services.displayManager.sddm = {
  #   enable = true;
  #   package = pkgs.kdePackages.sddm;
  #   wayland.enable = true;
  # };
  # catppuccin.sddm = {
  #   accent = "blue";
  #   flavor = "mocha";
  #   background = /home/miguel/nixzero/assets/blurred.jpg;
  #   loginBackground = true;
  #   userIcon = true;
  #   clockEnabled = false;
  # };

  programs.dankMaterialShell.greeter = {
    enable = true;
    compositor = {
      name = "niri";
      customConfig = ''
              hotkey-overlay {
            skip-at-startup
        }

        environment {
            DMS_RUN_GREETER "1"
        }

        gestures {
          hot-corners {
            off
          }
        }

        layout {
          background-color "#000000"
        }
      '';
    };

    configHome = "/home/miguel";

    # Custom config files for non-standard config locations
    configFiles = [
      "/home/miguel/.config/DankMaterialShell/settings.json"
    ];

    # Save the logs to a file
    logs = {
      save = true;
      path = "/tmp/dms-greeter.log";
    };

    # Custom Quickshell Package
    quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
      withX11 = false;
      withCrashReporter = false;
    };
  };

  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };
  environment.systemPackages = with pkgs; [
    wayland-utils
    xwayland-satellite-unstable
  ];
  environment.variables.NIXOS_OZONE_WL = "1";
}
