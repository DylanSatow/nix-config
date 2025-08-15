{ config, pkgs, ... }: {
  imports = [
    ./default.nix
    ./hyprland
    ./stylix.nix
  ];

  home.homeDirectory = "/home/dylan";
}