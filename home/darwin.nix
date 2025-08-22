{ config, pkgs, ... }: {
  imports = [
    ./default.nix
    ./aerospace.nix
  ];

  home.homeDirectory = "/Users/dylan";
}