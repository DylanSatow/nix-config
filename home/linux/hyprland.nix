{ config, pkgs, ... }:
{
    wayland.windowManager.hyprland = {
        enable = true;
        settings = {
            monitor = [
                ",highrr,auto,1"
            ];

            input = {
                kb_layout = "us";
                follow_mouse = 1;
                sensitivity = 0;
            };
        };
    };
}
