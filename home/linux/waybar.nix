{ pkgs, config, lib, ...}: with lib; {
    programs.waybar = {
        enable = true;
        package = pkgs.waybar;
        systemd.enable = true;
        settings = [
            {
                layer = "top";
                position = "top";
                height = 38;
                spacing = 8;

                modules-left = [ "custom/startmenu" "hyprland/window" "hyprland/submap" ];
                modules-center = [ "hyprland/workspaces" ];
                modules-right = [ "network" "cpu" "memory" "pulseaudio" "battery" "custom/notification" "tray" "clock" "custom/exit" ];

                "hyprland/workspaces" = {
                    format = "{icon}";
                    format-icons = {
                        "1" = "󰲠";
                        "2" = "󰲢";
                        "3" = "󰲤";
                        "4" = "󰲦";
                        "5" = "󰲨";
                        "6" = "󰲪";
                        "7" = "󰲬";
                        "8" = "󰲮";
                        "9" = "󰲰";
                        "10" = "󰿬";
                        default = "";
                        active = "";
                        urgent = "";
                    };
                    persistent-workspaces = {
                        "1" = [];
                        "2" = [];
                        "3" = [];
                        "4" = [];
                        "5" = [];
                    };
                    on-scroll-up = "hyprctl dispatch workspace e+1";
                    on-scroll-down = "hyprctl dispatch workspace e-1";
                };
                "clock" = {
                    format = "{:%I:%M %p}";
                    format-alt = "{:%A, %B %d, %Y (%I:%M %p)}";
                    tooltip = true;
                    tooltip-format = "<big>{:%A, %B %d, %Y}</big>\n<tt><small>{calendar}</small></tt>";
                };
                "hyprland/window" = {
                    max-length = 50;
                    separate-outputs = false;
                    rewrite = {
                        "" = "🏠 Desktop";
                        "(.*) — Mozilla Firefox" = "󰈹 $1";
                        "(.*) - Visual Studio Code" = " $1";
                        "(.*) - kitty" = "󰄛 $1";
                    };
                };
                "hyprland/submap" = {
                    format = " {}";
                    max-length = 20;
                    tooltip = false;
                };
                "memory" = {
                    interval = 10;
                    format = "󰍛 {percentage}%";
                    format-alt = "󰍛 {used:0.1f}G/{total:0.1f}G";
                    tooltip = true;
                    tooltip-format = "RAM: {used:0.1f}GB/{total:0.1f}GB ({percentage}%)\nSwap: {swapUsed:0.1f}GB/{swapTotal:0.1f}GB";
                    on-click = "kitty -e btop";
                    states = {
                        warning = 75;
                        critical = 90;
                    };
                };
                "cpu" = {
                    interval = 10;
                    format = "󰻠 {usage}%";
                    format-alt = "󰻠 {avg_frequency}GHz";
                    tooltip = true;
                    tooltip-format = "Load: {load}\nUsage per core:\n{usage0}% {usage1}% {usage2}% {usage3}%\n{usage4}% {usage5}% {usage6}% {usage7}%";
                    on-click = "kitty -e btop";
                    states = {
                        warning = 70;
                        critical = 90;
                    };
                };
                "network" = {
                    format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
                    format-ethernet = " {bandwidthDownBytes}";
                    format-wifi = "{icon} {essid} ({signalStrength}%)";
                    format-disconnected = "󰤮 Disconnected";
                    tooltip = true;
                    tooltip-format-wifi = "SSID: {essid}\nStrength: {signalStrength}%\nFrequency: {frequency}MHz\nIP: {ipaddr}\nGateway: {gwaddr}\nDown: {bandwidthDownBytes}\nUp: {bandwidthUpBytes}";
                    tooltip-format-ethernet = "Interface: {ifname}\nIP: {ipaddr}\nGateway: {gwaddr}\nDown: {bandwidthDownBytes}\nUp: {bandwidthUpBytes}";
                    on-click = "nm-connection-editor";
                    interval = 5;
                };
                "tray" = {
                    icon-size = 18;
                    spacing = 8;
                    reverse-direction = true;
                };
                "pulseaudio" = {
                    format = "{icon} {volume}%";
                    format-muted = "󱝿 Muted";
                    format-bluetooth = "󰂯 {volume}%";
                    format-bluetooth-muted = "󰂲 Muted";
                    format-icons = {
                        headphone = "";
                        hands-free = "";
                        headset = "";
                        phone = "";
                        portable = "";
                        car = "";
                        default = ["󱟿" "󰕾" "󰖀"];
                    };
                    scroll-step = 5;
                    on-click = "pavucontrol";
                    on-click-right = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
                    tooltip = true;
                    tooltip-format = "Volume: {volume}%\nDevice: {desc}";
                };
                "custom/exit" = {
                    tooltip = true;
                    tooltip-format = "Power Menu";
                    format = "";
                    on-click = "wlogout";
                };
                "custom/startmenu" = {
                    tooltip = true;
                    tooltip-format = "Application Launcher";
                    format = "";
                    on-click = "rofi -show drun";
                };
                "custom/notification" = {
                    tooltip = true;
                    tooltip-format = "Notifications";
                    format = "{icon}";
                    format-icons = {
                        notification = "<span foreground='#f38ba8'></span>";
                        none = "";
                        dnd-notification = "<span foreground='#f38ba8'></span>";
                        dnd-none = "";
                        inhibited-notification = "<span foreground='#f38ba8'></span>";
                        inhibited-none = "";
                        dnd-inhibited-notification = "<span foreground='#f38ba8'></span>";
                        dnd-inhibited-none = "";
                    };
                    return-type = "json";
                    exec-if = "which swaync-client";
                    exec = "swaync-client -swb";
                    on-click = "swaync-client -t -R";
                    on-click-right = "swaync-client -d -R";
                    escape = true;
                };
                "battery" = {
                    states = {
                        good = 80;
                        warning = 30;
                        critical = 15;
                    };
                    format = "{icon} {capacity}%";
                    format-charging = " {capacity}%";
                    format-plugged = "󱘖 {capacity}%";
                    format-full = " Full";
                    format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
                    tooltip = true;
                    tooltip-format = "Battery: {capacity}%\nTime remaining: {time}\nPower: {power}W\nCycles: {cycles}";
                    on-click = "gnome-power-statistics";
                };
            }
        ];
        style = ''
            * {
                font-family: ${config.stylix.fonts.monospace.name};
                font-size: 14px;
                border: none;
                border-radius: 0;
                min-height: 0;
                padding: 0;
                margin: 0;
            }

            window#waybar {
                background: transparent;
                color: #${config.lib.stylix.colors.base05};
            }

            #workspaces {
                background: #${config.lib.stylix.colors.base01};
                padding: 4px 8px;
                margin: 4px 0;
                border-radius: 12px;
            }

            #workspaces button {
                padding: 4px 8px;
                margin: 0 2px;
                border-radius: 8px;
                color: #${config.lib.stylix.colors.base04};
                background: transparent;
                transition: all 0.2s ease;
            }

            #workspaces button.active {
                color: #${config.lib.stylix.colors.base00};
                background: linear-gradient(135deg, #${config.lib.stylix.colors.base0D}, #${config.lib.stylix.colors.base0E});
                min-width: 24px;
            }

            #workspaces button:hover {
                color: #${config.lib.stylix.colors.base05};
                background: #${config.lib.stylix.colors.base02};
            }

            #window {
                color: #${config.lib.stylix.colors.base05};
                background: #${config.lib.stylix.colors.base01};
                padding: 6px 12px;
                margin: 4px 4px 4px 0;
                border-radius: 12px;
                font-weight: 500;
            }

            #submap {
                color: #${config.lib.stylix.colors.base00};
                background: #${config.lib.stylix.colors.base08};
                padding: 6px 12px;
                margin: 4px 0;
                border-radius: 12px;
                font-weight: 600;
            }

            #clock {
                color: #${config.lib.stylix.colors.base00};
                background: linear-gradient(135deg, #${config.lib.stylix.colors.base0C}, #${config.lib.stylix.colors.base0D});
                padding: 6px 16px;
                margin: 4px 0 4px 4px;
                border-radius: 12px;
                font-weight: 600;
            }

            #custom-startmenu {
                color: #${config.lib.stylix.colors.base00};
                background: linear-gradient(135deg, #${config.lib.stylix.colors.base08}, #${config.lib.stylix.colors.base09});
                padding: 8px 16px;
                margin: 4px 0 4px 4px;
                border-radius: 12px 0 0 12px;
                font-size: 16px;
            }

            #custom-exit {
                color: #${config.lib.stylix.colors.base00};
                background: #${config.lib.stylix.colors.base08};
                padding: 8px 16px;
                margin: 4px 4px 4px 0;
                border-radius: 0 12px 12px 0;
                font-size: 16px;
            }

            #cpu, #memory {
                color: #${config.lib.stylix.colors.base00};
                background: #${config.lib.stylix.colors.base0A};
                padding: 6px 12px;
                margin: 4px 0;
                border-radius: 12px;
                font-weight: 500;
            }

            #cpu.warning {
                background: #${config.lib.stylix.colors.base09};
            }

            #cpu.critical,
            #memory.warning {
                background: #${config.lib.stylix.colors.base08};
                animation: blink 1s linear infinite alternate;
            }

            #memory.critical {
                background: #${config.lib.stylix.colors.base08};
                animation: blink 0.5s linear infinite alternate;
            }

            #network {
                color: #${config.lib.stylix.colors.base00};
                background: #${config.lib.stylix.colors.base0B};
                padding: 6px 12px;
                margin: 4px 0;
                border-radius: 12px;
                font-weight: 500;
            }

            #network.disconnected {
                background: #${config.lib.stylix.colors.base08};
            }

            #pulseaudio {
                color: #${config.lib.stylix.colors.base00};
                background: #${config.lib.stylix.colors.base0D};
                padding: 6px 12px;
                margin: 4px 0;
                border-radius: 12px;
                font-weight: 500;
            }

            #pulseaudio.muted {
                color: #${config.lib.stylix.colors.base03};
                background: #${config.lib.stylix.colors.base01};
            }

            #battery {
                color: #${config.lib.stylix.colors.base00};
                background: #${config.lib.stylix.colors.base0B};
                padding: 6px 12px;
                margin: 4px 0;
                border-radius: 12px;
                font-weight: 500;
            }

            #battery.warning {
                background: #${config.lib.stylix.colors.base09};
            }

            #battery.critical {
                background: #${config.lib.stylix.colors.base08};
                animation: blink 1s linear infinite alternate;
            }

            #battery.charging {
                color: #${config.lib.stylix.colors.base00};
                background: linear-gradient(135deg, #${config.lib.stylix.colors.base0B}, #${config.lib.stylix.colors.base0C});
            }

            #tray {
                background: #${config.lib.stylix.colors.base01};
                padding: 6px 8px;
                margin: 4px 0;
                border-radius: 12px;
            }

            #custom-notification {
                color: #${config.lib.stylix.colors.base05};
                background: #${config.lib.stylix.colors.base01};
                padding: 6px 12px;
                margin: 4px 0;
                border-radius: 12px;
                font-weight: 500;
            }

            tooltip {
                background: #${config.lib.stylix.colors.base00};
                border: 2px solid #${config.lib.stylix.colors.base0D};
                border-radius: 8px;
                color: #${config.lib.stylix.colors.base05};
            }

            @keyframes blink {
                from {
                    opacity: 1;
                }
                to {
                    opacity: 0.7;
                }
            }
        '';
    };
}