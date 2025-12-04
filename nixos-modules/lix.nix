{pkgs, ...}: {
  nixpkgs.overlays = [
    (final: prev: {
      inherit
        (final.lixPackageSets.git)
        nixpkgs-review
        nix-direnv
        nix-eval-jobs
        nix-fast-build
        colmena
        nil
        ;
    })
  ];

  #nix.package = pkgs.lixPackageSets.git.lix;
  nix.package = pkgs.lixPackageSets.stable.lix;
}
