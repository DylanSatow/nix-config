{ pkgs, ... }:

{
  environment.systemPackages = with pkgs.unstable; [
    ffmpeg
    poppler
    jq
  ];
}
