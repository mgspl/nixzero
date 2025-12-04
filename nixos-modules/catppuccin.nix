{inputs, ...}: {
  imports = [inputs.catppuccin.nixosModules.catppuccin];

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "blue";
    cache.enable = true;
  };
}

