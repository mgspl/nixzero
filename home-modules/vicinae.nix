{
  pkgs,
  inputs,
  lib,
  ...
}: {
  services.vicinae = {
    enable = true; # default: false
    autoStart = true; # default: true
    settings = {
      userLayerShell = false;
      faviconService = "twenty";
      font.size = 12;
      popToRootOnClose = false;
      rootSearch.searchFiles = false;
      theme.name = "catppuccin-mocha";
      window = {
        csd = true;
        opacity = 0.95;
        rounding = 8;
      };
    };
  };

  systemd.user.services.vicinae = {
    Service.Environment = lib.mkForce ["USE_LAYER_SHELL=0"];
    Service.EnvironmentFile = lib.mkForce [];
  };
}
