{ hostname, lib, ... } : {
    programs.kitty = {
        enable = true;
        settings = {
            font_family = "JetBrainsMono Nerd Font";
            font_size = 12;
            cursor_shape = "beam";
            cursor_trail = 1;

        } // lib.optionalAttrs (hostname == "dylanmac") {
            macos_option_as_alt = "yes";
        };
    };
    programs.alacritty = {
        enable = true;
        settings = {
            font = {
                size = 11;
                normal = {
                    family = "JetBrains Mono Nerd Font";
                    style = "Regular";
                };
            };
            cursor.style.shape = "beam";
        };
    };
}
