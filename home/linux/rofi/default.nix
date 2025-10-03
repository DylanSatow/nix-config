{ pkgs, ... }: {
    programs.rofi = {
        enable = true;
        package = pkgs.rofi-wayland;
        extraConfig = builtins.readFile ./config.rasi;
    };
}