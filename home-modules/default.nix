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
      exportModules
      firefox
      gammastep
      kitty
      mango
      mpv
      neovim
      packages
      portals
      starship
      swayidle
      swaylock
      swayosd
      theme
      waybar
      wlogout
      ;
  };

  programs.home-manager.enable = true;
}
