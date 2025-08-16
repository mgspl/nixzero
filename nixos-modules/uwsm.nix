{
  pkgs,
  config,
  lib,
  ...
}: {
  services.greetd = let
    session = {
      command = "${lib.getExe config.programs.uwsm.package} start -- mango-uwsm.desktop";
      # command = "dbus-run-session ${pkgs.swayfx}/bin/sway";
      user = "miguel";
    };
  in {
    enable = true;
    settings = {
      terminal.vt = 1;
      default_session = session;
      initial_session = session;
    };
  };

  programs.regreet = {
    enable = false;

    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
    };

    iconTheme = {
      name = "Colloid-Catppuccin-Dark";
      package = pkgs.colloid-icon-theme.override {
        schemeVariants = ["catppuccin"];
        colorVariants = ["default"];
      };
    };

    theme = {
      name = "Colloid-Dark-Catppuccin";
      package = pkgs.colloid-gtk-theme.override {
        themeVariants = ["default"];
        colorVariants = ["dark"];
        sizeVariants = ["standard"];
        tweaks = ["catppuccin" "rimless"];
      };
    };

    cageArgs = ["-s" "-m" "last"];
  };

  systemd.tmpfiles.rules = [
    "d /var/log/regreet 0755 greeter greeter - -"
    "d /var/cache/regreet 0755 greeter greeter - -"
  ];

  programs.uwsm = {
    enable = true;
    /*
        waylandCompositors.sway = {
      binPath = "${lib.getExe  pkgs.swayfx}";
      prettyName = "Sway";
      comment = "Sway managed by UWSM";
    };
    */

    
      waylandCompositors.mango = {
      binPath = "/run/current-system/sw/bin/mango";
      prettyName = "Mango";
      comment = "Mango managed by UWSM";
    };
  };
}
