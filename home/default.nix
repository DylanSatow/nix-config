{ pkgs, ... }: {
    imports = [
        ./apps/firefox.nix
        ./apps/git.nix
        ./apps/nvim.nix
        ./apps/shell.nix
        ./linux/kitty/default.nix
    ];

    home = {
        username = "dylan";
        homeDirectory = "/home/dylan";
        stateVersion = "25.05"; 
    };
    programs.home-manager.enable = true; 
}
