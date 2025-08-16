{
  pkgs,
  inputs,
  ...
}: {
  programs.steam = {
    enable = true;
    
    package = pkgs.steam.override {
      # some launch args that work better for me
      extraArgs = "-silent -system-composer -skipstreamingdrivers -cef-disable-breakpad -cef-disable-seccomp-sandbox -cef-disable-js-logging -no-cef-sandbox";
    };

    extraCompatPackages = [
      pkgs.proton-cachyos_x86_64_v3
    ];
  };
}
