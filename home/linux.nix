{ config, pkgs, ... }: {
  imports = [
    ./default.nix
    ./hyprland
    ./stylix.nix
    ./waybar.nix
  ];

  home.homeDirectory = "/home/dylan";
}