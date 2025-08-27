{ config, pkgs, ... }: {
    imports = [
        ./default.nix
        ./hyprland
        ./stylix.nix
        ./waybar.nix
        ./rofi.nix
    ];

    home.homeDirectory = "/home/dylan";
    
    stylix.targets.firefox.profileNames = [ "dylan" ];
}