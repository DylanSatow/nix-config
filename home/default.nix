{ lib, catppuccin, hostname, ... }: {
    imports = [
        ./apps
    ] ++ lib.optional (hostname == "dylanpc") ./niri;

    catppuccin = {
        enable = true;
        flavor = "mocha";
        accent = "lavender";
    };
    
    home = {
        stateVersion = "25.05"; 
    } // lib.optionalAttrs(hostname == "dylanpc") {
        username = "dylan";
        homeDirectory = "/home/dylan";
    };
    programs.home-manager.enable = true; 
}
