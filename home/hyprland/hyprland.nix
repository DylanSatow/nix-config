{ config, pkgs, ... }:

{
    

    home.packages = with pkgs; [
        waybar
        rofi-wayland
        swww
        grim
        slurp
        wl-clipboard
        brightnessctl
        playerctl
        pavucontrol
        networkmanagerapplet
        mako
        hyprpicker
        hypridle
        hyprlock
    ];

    wayland.windowManager.hyprland = {
        enable = true;
        settings = {
            "$mod" = "SUPER";
            "$terminal" = "kitty";
            "$fileManager" = "nautilus";
            "$menu" = "rofi -show drun";
            "$browser" = "firefox";
            "$life" = "obsidian";
            "$code" = "neovide";
            "$vscode" = "code";

            monitor = [
                ",highrr,auto,1"
            ];

            env = [
                "XCURSOR_SIZE,24"
                "HYPRCURSOR_SIZE,24"
            ];

            input = {
                kb_layout = "us";
                follow_mouse = 1;
                sensitivity = 0;
                
                touchpad = {
                    natural_scroll = false;
                };
            };

            general = {
                gaps_in = 5;
                gaps_out = 20;
                border_size = 2;
                
                
                
                resize_on_border = false;
                allow_tearing = false;
                layout = "dwindle";
            };

            decoration = {
                rounding = 10;
                active_opacity = 1.0;
                inactive_opacity = 1.0;
                
                
                blur = {
                    enabled = true;
                    size = 3;
                    passes = 1;
                    vibrancy = 0.1696;
                };
            };

            animations = {
                enabled = true;
                bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
                
                animation = [
                    "windows, 1, 7, myBezier"
                    "windowsOut, 1, 7, default, popin 80%"
                    "border, 1, 10, default"
                    "borderangle, 1, 8, default"
                    "fade, 1, 7, default"
                    "workspaces, 1, 6, default"
                ];
            };

            dwindle = {
                pseudotile = true;
                preserve_split = true;
            };

            master = {
                new_status = "master";
            };

            misc = {
                force_default_wallpaper = -1;
                mouse_move_enables_dpms = true;
                key_press_enables_dpms = true;
                disable_hyprland_logo = true;
            };

            cursor = {
                no_hardware_cursors = true;
                hide_on_key_press = false;
                inactive_timeout = 0;
            };

            

            

            

            
        };
    };

    
}
