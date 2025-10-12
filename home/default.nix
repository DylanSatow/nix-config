{ pkgs, ... }: {
    imports = [
        ./apps
        ./gnome.nix
    ];

    home = {
        username = "dylan";
        homeDirectory = "/home/dylan";
        stateVersion = "25.05"; 
    };
    programs.home-manager.enable = true; 
}
