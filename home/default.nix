{ pkgs, catppuccin, ... }: {
    imports = [
        ./apps
        ./gnome
    ];

    catppuccin = {
        enable = true;
        flavor = "mocha";
        accent = "lavender";
    };

    home = {
        username = "dylan";
        homeDirectory = "/home/dylan";
        stateVersion = "25.05"; 
    };
    programs.home-manager.enable = true; 
}
