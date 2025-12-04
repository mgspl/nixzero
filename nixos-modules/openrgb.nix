{
  pkgs,
  lib,
  ...
}:
/*
     let
  openrgb = pkgs.openrgb.overrideAttrs {
    version = "git";
    src = pkgs.fetchFromGitLab {
      owner = "CalcProgrammer1";
      repo = "OpenRGB";
      rev = "8a63cfbf2581ed35c7c771bcaa5516678238acc3";
      hash = "sha256-UyllLHdyzZf/Fxp2oW2MDw0o28FruJBNiRZv7LL/mAo=";
    };
    postPatch = ''
      patchShebangs scripts/build-udev-rules.sh
      substituteInPlace scripts/build-udev-rules.sh \
        --replace "/usr/bin/env chmod" "${lib.getExe' pkgs.coreutils "chmod"}"
    '';
  };
in
*/
{
  # Enable OpenRGB

  services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb_git;
  };
  services.udev.packages = [pkgs.openrgb_git];
}
