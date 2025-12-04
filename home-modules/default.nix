{
  ezModules,
  lib,
  inputs,
  ...
}: {
  imports = lib.attrValues {
    inherit
      (ezModules)
      btop
      dms
      exportModules
      firefox
      gammastep
      helix
      kitty
      mpv
      niri
      packages
      starship
      theme
      vesktop
      zed
      ;
  };

  programs.home-manager.enable = true;
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    # Overlays
    overlays = [
      (import ../packages/overlay.nix)
      inputs.niri.overlays.niri
    ];
  };
}
