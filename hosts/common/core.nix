{ pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs.unstable; [
    zip
    unzip
    btop
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];
}
