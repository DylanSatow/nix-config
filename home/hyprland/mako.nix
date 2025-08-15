{ config, pkgs, ... }:

{
  services.mako = {
    enable = true;
    backgroundColor = "#1e1e2e";
    textColor = "#cdd6f4";
    borderColor = "#89b4fa";
    borderRadius = 10;
    borderSize = 2;
    defaultTimeout = 5000;
    layer = "overlay";
  };
}