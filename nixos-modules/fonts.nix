{pkgs, ...}: {
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    packages = with pkgs; [
      nerd-fonts.adwaita-mono
      noto-fonts
      noto-fonts-color-emoji
    ];
    fontconfig = {
      enable = true;
      useEmbeddedBitmaps = true;
    };
  };
}
