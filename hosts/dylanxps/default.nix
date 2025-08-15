{ config, pkgs, ... }: {
  imports = [
    ./hardware.nix
    ./system.nix
    ./hyprland.nix
  ];
}