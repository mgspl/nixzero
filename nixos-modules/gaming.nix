{
  pkgs,
  inputs,
  ...
}: {
  # Enable NTSync
  boot.kernelModules = ["ntsync"];

  /*
    services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-rules-cachyos_git;

    # Eternal Return rule :3
    extraRules = [
      {
        name = "EternalReturn.exe";
        type = "Game";
      }
    ];
  };
  */

  environment.systemPackages = [
    pkgs.mangohud
    pkgs.mangojuice
  ];

  programs.nix-ld.enable = true;

  programs.steam = {
    enable = true;

    package = pkgs.steam.override {
      # some launch args that work better for me
      extraArgs = "-silent -system-composer -skipstreamingdrivers -cef-disable-breakpad -cef-disable-seccomp-sandbox -cef-disable-js-logging -no-cef-sandbox";
      extraEnv = {
        MANGOHUD = true;
        OBS_VKCAPTURE = true;
        PROTON_USE_NTSYNC = true;
        LD_PRELOAD = "";
      };
    };

    extraCompatPackages = [
      pkgs.proton-cachyos_x86_64_v3
    ];
  };
}
