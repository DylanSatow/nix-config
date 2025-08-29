{ config, pkgs, ... }: {
    imports = [
        ./default.nix
        ./hyprland
        ./stylix.nix
        ./waybar.nix
        ./rofi.nix
    ];

    home.homeDirectory = "/home/dylan";
    
    xdg.userDirs = {
        enable = true;
        desktop = null;
        documents = null;
    };
    
    stylix.targets.firefox.profileNames = [ "dylan" ];
}