{ config, pkgs, ... }: {
  imports = [
    ./system.nix
    ./packages.nix
  ];
}