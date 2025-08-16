{pkgs, ...}: {
  home.packages = with pkgs; [
    # Programs
    discord
    loupe
    nautilus
    papers
    losslesscut-bin
    youtube-music
    gnome-calculator
    gnome-text-editor

    # Tools
    unzip
    zip
    killall
    wlr-randr
    pamixer
    wlr-randr
    microfetch

    # Fonts
    nerd-fonts.adwaita-mono
    noto-fonts

    # Compositor
    playerctl
    clipse
    pwvucontrol
    imagemagick
    wl-clipboard
    xdg-utils
    xdg-user-dirs
  ];
}
