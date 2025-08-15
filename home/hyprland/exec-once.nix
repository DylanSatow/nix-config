{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "waybar"
      "mako"
      "swww-daemon"
      "nm-applet --indicator"
      "blueman-applet"
      "hypridle"
      "swww img ~/home/nix-config/home/wallpapers/Rainnight.jpg"
    ];
  };
}