{pkgs, ...}: {
  programs.vivaldi = {
    enable = true;
    package = pkgs.vivaldi.override {
      commandLineArgs = [
        "--password-store=gnome-libsecret"
        "--force-dark-mode"
        "--gtk-version=4"
        "--ozone-platform=wayland"
        "--enable-features=UseOzonePlatform"
        "--enable-features=AcceleratedVideoEncoder"
        "--ignore-gpu-blocklist"
        "--enable-zero-copy"
      ];
    };
    extensions = [
      {id = "ammjkodgmmoknidbanneddgankgfejfh";} # 7TV
      {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # Ublokc
      {id = "mnjggcdmjocbbbhaepdhchncahnbgone";} # Sponsor Block
      {id = "nngceckbapebfimnlniiiahkandclblb";} # Bitwarden
      {id = "jaoafjdoijdconemdmodhbfpianehlon";} # Skip Redirect
    ];
  };

  services.psd = {
    enable = true;
    browsers = ["vivaldi"];
  };
}
