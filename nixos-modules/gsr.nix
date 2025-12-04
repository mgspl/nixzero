{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = [
    pkgs.gpu-screen-recorder-ui
    pkgs.gpu-screen-recorder
  ];
  security.wrappers = {
    "gsr-global-hotkeys" = {
      owner = "root";
      group = "root";
      capabilities = "cap_setuid+ep";
      source = lib.getExe' pkgs.gpu-screen-recorder-ui "gsr-global-hotkeys";
    };
    "gsr-kms-server" = {
      owner = "root";
      group = "root";
      capabilities = "cap_sys_admin+ep";
      source = lib.getExe' pkgs.gpu-screen-recorder "gsr-kms-server";
    };
  };
}
