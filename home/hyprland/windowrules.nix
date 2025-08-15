{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      "suppressevent maximize, class:.*"
      "float,class:^(pavucontrol)$"
      "float,class:^(blueman-manager)$"
      "float,class:^(nm-applet)$"
      "float,class:^(nm-connection-editor)$"
    ];
  };
}