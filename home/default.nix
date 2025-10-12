{ pkgs, ... }: {
    imports = [
        ./apps 
        ./linux
    ];

    home = {
        username = "dylan";
        homeDirectory = "/home/dylan";
        stateVersion = "25.05"; 
    };
    programs.home-manager.enable = true; 
}
