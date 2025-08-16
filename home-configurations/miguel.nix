{
  home = {
    username = "miguel";
    homeDirectory = "/home/miguel";
    stateVersion = "23.05";
  };

  programs.git = {
    userName = "Miguel";
    userEmail = "miguelsilvapeloso@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
