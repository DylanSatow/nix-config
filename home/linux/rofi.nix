{ pkgs
, config
, lib
, ...
}: {
    programs = {
        rofi = {
            enable = true;
            package = pkgs.rofi-wayland;
            extraConfig = {
                modi = "drun,run,filebrowser";
                show-icons = true;
                icon-theme = "Papirus";
                font = "JetBrainsMono Nerd Font Mono 12";
                drun-display-format = "{icon} {name}";
                display-drun = "󰀻 Apps";
                display-run = " Run";
                display-filebrowser = "󰉋 Files";
            };
            theme = lib.mkForce (
                let
                    inherit (config.lib.formats.rasi) mkLiteral;
                in
                {
                    "*" = {
                        bg = mkLiteral "#${config.lib.stylix.colors.base00}";
                        bg-alt = mkLiteral "#${config.lib.stylix.colors.base01}";
                        bg-selected = mkLiteral "#${config.lib.stylix.colors.base02}";
                        fg = mkLiteral "#${config.lib.stylix.colors.base05}";
                        fg-alt = mkLiteral "#${config.lib.stylix.colors.base04}";
                        border-color = mkLiteral "#${config.lib.stylix.colors.base0D}";
                        selected = mkLiteral "#${config.lib.stylix.colors.base0D}";
                        urgent = mkLiteral "#${config.lib.stylix.colors.base08}";
                    };
                    "window" = {
                        transparency = "real";
                        width = mkLiteral "600px";
                        location = mkLiteral "center";
                        anchor = mkLiteral "center";
                        fullscreen = false;
                        x-offset = mkLiteral "0px";
                        y-offset = mkLiteral "0px";
                        cursor = "default";
                        enabled = true;
                        border-radius = mkLiteral "12px";
                        border = mkLiteral "2px solid";
                        border-color = mkLiteral "@border-color";
                        background-color = mkLiteral "@bg";
                    };
                    "mainbox" = {
                        enabled = true;
                        spacing = mkLiteral "12px";
                        padding = mkLiteral "16px";
                        background-color = mkLiteral "transparent";
                        children = map mkLiteral [
                            "inputbar"
                            "listview"
                            "mode-switcher"
                        ];
                    };
                    "inputbar" = {
                        enabled = true;
                        spacing = mkLiteral "8px";
                        padding = mkLiteral "12px 16px";
                        border-radius = mkLiteral "12px";
                        background-color = mkLiteral "@bg-alt";
                        text-color = mkLiteral "@fg";
                        children = map mkLiteral [
                            "textbox-prompt-colon"
                            "entry"
                        ];
                    };
                    "textbox-prompt-colon" = {
                        enabled = true;
                        expand = false;
                        str = "󰀻";
                        background-color = mkLiteral "inherit";
                        text-color = mkLiteral "@border-color";
                    };
                    "entry" = {
                        enabled = true;
                        background-color = mkLiteral "inherit";
                        text-color = mkLiteral "inherit";
                        cursor = mkLiteral "text";
                        placeholder = "Search applications...";
                        placeholder-color = mkLiteral "@fg-alt";
                    };
                    "listview" = {
                        enabled = true;
                        columns = 1;
                        lines = 8;
                        cycle = true;
                        dynamic = true;
                        scrollbar = false;
                        layout = mkLiteral "vertical";
                        reverse = false;
                        fixed-height = true;
                        fixed-columns = true;
                        spacing = mkLiteral "4px";
                        background-color = mkLiteral "transparent";
                        text-color = mkLiteral "@fg";
                        cursor = "default";
                    };
                    "element" = {
                        enabled = true;
                        spacing = mkLiteral "12px";
                        padding = mkLiteral "8px 12px";
                        border-radius = mkLiteral "8px";
                        background-color = mkLiteral "transparent";
                        text-color = mkLiteral "@fg";
                        cursor = mkLiteral "pointer";
                    };
                    "element normal.normal" = {
                        background-color = mkLiteral "transparent";
                        text-color = mkLiteral "@fg";
                    };
                    "element normal.urgent" = {
                        background-color = mkLiteral "@urgent";
                        text-color = mkLiteral "@bg";
                    };
                    "element normal.active" = {
                        background-color = mkLiteral "transparent";
                        text-color = mkLiteral "@fg";
                    };
                    "element selected.normal" = {
                        background-color = mkLiteral "@bg-selected";
                        text-color = mkLiteral "@fg";
                        border = mkLiteral "1px solid";
                        border-color = mkLiteral "@selected";
                    };
                    "element selected.urgent" = {
                        background-color = mkLiteral "@urgent";
                        text-color = mkLiteral "@bg";
                    };
                    "element selected.active" = {
                        background-color = mkLiteral "@bg-selected";
                        text-color = mkLiteral "@fg";
                        border = mkLiteral "1px solid";
                        border-color = mkLiteral "@selected";
                    };
                    "element-icon" = {
                        background-color = mkLiteral "transparent";
                        text-color = mkLiteral "inherit";
                        size = mkLiteral "24px";
                        cursor = mkLiteral "inherit";
                    };
                    "element-text" = {
                        background-color = mkLiteral "transparent";
                        text-color = mkLiteral "inherit";
                        cursor = mkLiteral "inherit";
                        vertical-align = mkLiteral "0.5";
                        horizontal-align = mkLiteral "0.0";
                    };
                    "mode-switcher" = {
                        enabled = true;
                        spacing = mkLiteral "8px";
                        background-color = mkLiteral "transparent";
                        text-color = mkLiteral "@fg";
                    };
                    "button" = {
                        padding = mkLiteral "8px 12px";
                        border-radius = mkLiteral "8px";
                        background-color = mkLiteral "@bg-alt";
                        text-color = mkLiteral "@fg-alt";
                        cursor = mkLiteral "pointer";
                    };
                    "button selected" = {
                        background-color = mkLiteral "@selected";
                        text-color = mkLiteral "@bg";
                    };
                    "message" = {
                        background-color = mkLiteral "transparent";
                    };
                    "textbox" = {
                        padding = mkLiteral "12px 16px";
                        border-radius = mkLiteral "8px";
                        background-color = mkLiteral "@bg-alt";
                        text-color = mkLiteral "@fg";
                        vertical-align = mkLiteral "0.5";
                        horizontal-align = mkLiteral "0.0";
                    };
                    "error-message" = {
                        padding = mkLiteral "12px";
                        border-radius = mkLiteral "8px";
                        background-color = mkLiteral "@urgent";
                        text-color = mkLiteral "@bg";
                    };
                }
            );
        };
    };
}