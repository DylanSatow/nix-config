{ config, pkgs, ... }:

{
    wayland.windowManager.hyprland.settings = {
        exec-once = [
            "mako"
            "swww-daemon"
            "nm-applet --indicator"
            "blueman-applet"
            "hypridle"
            "swww img ~/home/nix-config/home/wallpapers/jazz.jpg"
        ];
    };
}
