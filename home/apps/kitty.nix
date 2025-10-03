{ pkgs, ... }: {
    programs.kitty = {
        enable = true;
        themeFile = "Catppuccin-Macchiato";
        settings = {
            font_family = "JetBrainsMono Nerd Font";
            font_size = 12;
    
            bold_font = "auto";
            italic_font = "auto";
            bold_italic_font = "auto";

            cursor_shape = "beam";
            cursor_trail = 1;
            
            background_blur = 30;
        };
    };
}