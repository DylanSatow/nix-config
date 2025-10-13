{ pkgs, ... }: {
    programs.zsh = {
        enable = true; 

        oh-my-zsh = {
            enable = true; 
            theme = "robbyrussell";
        };
        shellAliases = {
            # dconf dump / | dconf2nix > ~/nix-config/home/gnome/dconf.nix
            nrb = ''
                sudo nixos-rebuild switch --flake ~/nix-config#dylanpc
            '';
        };
    };
    programs.direnv = {
        enable = true; 
        enableZshIntegration  =true; 
        nix-direnv.enable = true;
    };

    programs.zellij = {
        enable = true;
        enableZshIntegration = true;  
    };

    programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
    };
}
