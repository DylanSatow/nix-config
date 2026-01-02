{ pkgs, ... }:

{
  environment.systemPackages = with pkgs.unstable; [
    zip
    unzip
    btop
  ];
}
