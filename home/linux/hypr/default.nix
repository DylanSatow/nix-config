{ config, pkgs, ... }:
{
    wayland.windowManager.hyprland = {
        enable = true;
        extraConfig = builtins.readFile ./hyprland.conf;
    };

    # Symlink all hypr config files
    home.file = {
        ".config/hypr/conf" = {
            source = ./conf;
            recursive = true;
        };
        ".config/hypr/hyprpaper.conf".source = ./hyprpaper.conf;
        ".config/hypr/hyprlock.conf".source = ./hyprlock.conf;
    };
}