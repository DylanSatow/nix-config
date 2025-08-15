{ config, pkgs, ... }: {
  imports = [
    ./default.nix
    ./hyprland.nix
  ];

  home.homeDirectory = "/home/dylan";
}