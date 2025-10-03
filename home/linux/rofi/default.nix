{ pkgs, ... }: {
    programs.rofi = {
        enable = true;
        package = pkgs.rofi-wayland;
    };

    # Symlink rofi config files
    home.file = {
        ".config/rofi/config.rasi".source = ./config.rasi;
    };
}