{ config, pkgs, ... }: {
  imports = [
    ./hardware.nix
    ./system.nix
    ./packages.nix
  ];
}