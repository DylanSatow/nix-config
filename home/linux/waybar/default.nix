{ pkgs, ... }: {
    programs.waybar = {
        enable = true;
    };

    # Symlink waybar config files
    home.file = {
        ".config/waybar/config".source = ./config;
        ".config/waybar/modules.json".source = ./modules.json;
        ".config/waybar/style.css".source = ./style.css;
        
        # ML4W support files
        ".config/ml4w" = {
            source = ./ml4w;
            recursive = true;
        };
    };
}