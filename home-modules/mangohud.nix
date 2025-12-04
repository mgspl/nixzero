{pkgs, ...}: {
  catppuccin.mangohud = {
    enable = true;
    flavor = "mocha";
  };
  programs.mangohud = {
    enable = true;
  };
  home.packages = with pkgs; [
    mangojuice
    mangohud
  ];
}
