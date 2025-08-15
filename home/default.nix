{ config, pkgs, ... }: {
  imports = [
    ./editors.nix
    ./browsers.nix
    ./terminal.nix
    ./development.nix
  ];

  home.username = "dylan";
  home.homeDirectory = if pkgs.stdenv.isDarwin then "/Users/dylan" else "/home/dylan";

  programs.git = {
    enable = true;
    userName = "DylanSatow";
    userEmail = "dylansatow531@gmail.com";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}