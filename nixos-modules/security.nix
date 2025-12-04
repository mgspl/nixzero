{pkgs, ...}: {
  security = {
    rtkit.enable = true;
    polkit.enable = true;
    pam.services.swaylock = {};
    #soteria.enable = true;
  };
}
