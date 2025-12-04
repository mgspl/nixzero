{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    # Programs
    vesktop
    loupe
    nautilus
    papers
    #youtube-music
    gnome-calculator
    gnome-text-editor
    kdePackages.kdenlive
    #zenmonitor

    inputs.ev357-nurpkgs.packages.${pkgs.stdenv.hostPlatform.system}.helium
    inputs.loneros-nurpkgs.packages.${pkgs.stdenv.hostPlatform.system}.pear-desktop

    windsurf
    #zed-editor-fhs

    # Tools
    unzip
    zip
    killall
    wlr-randr
    pamixer
    swaybg
    microfetch
    ffmpegthumbnailer

    # Gaming
    #heroic
    #inputs.nix-gaming.packages.${pkgs.system}.wine-cachyos

    # Compositor
    playerctl
    pwvucontrol
    imagemagick
    wl-clipboard
    xdg-utils
    xdg-user-dirs
  ];
}
