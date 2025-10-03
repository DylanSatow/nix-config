{ pkgs, ... }: {
    programs.zsh = {
        enable = true; 

        oh-my-zsh = {
            enable = true; 
            theme = "robbyrussell";
        };
        shellAliases = {
            nrb = "sudo nixos-rebuild switch --flake ~/nix-config#dylanpc";
        };
    };
    programs.direnv = {
        enable = true; 
        enableZshIntegration  =true; 
        nix-direnv.enable = true;
    };
}
