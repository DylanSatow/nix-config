{ config, pkgs, ... }: {
  imports = [
    ./default.nix
  ];

  home.homeDirectory = "/Users/dylan";
}