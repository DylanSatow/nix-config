{ config, pkgs, hostname ? "", ... }: {
    programs.zsh = {
        enable = true;

        oh-my-zsh = {
                enable = true;
                theme = "robbyrussell";
        };

        shellAliases = {
            nrb = {
                dylanix = "sudo darwin-rebuild switch --flake ~/home/nix-config#dylanix";
                dylanxps = "sudo nixos-rebuild switch --flake ~/nix-config#dylanxps";
                dylanpc = "sudo nixos-rebuild switch --flake ~/nix-config#dylanpc";
            }.${hostname};
        };

        initContent = if pkgs.stdenv.isDarwin then ''
            export PATH=$PATH:/Users/dylan/go/bin/

            function cd() {
                if [[ $# -eq 0 ]]; then
                    builtin cd "/Users/dylan/home"
                else
                    builtin cd "$@"
                fi
            }
            
            if [[ "$PWD" == "$HOME" && -z "$VSCODE_INJECTION" ]]; then
                if [[ -d "$HOME/home" ]]; then
                    cd "$HOME/home"
                fi
            fi
        '' else ''
            export PATH=$PATH:$HOME/go/bin/
        '';
    };

    programs.direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
    };

    programs.kitty = {
        enable = true;
        themeFile = "Catppuccin-Macchiato";
        settings = {
            font_family = "JetBrainsMono Nerd Font";
            font_size = {
                dylanix = 20;
                dylanxps = 16;
                dylanpc = 12;
            }.${hostname} or 12;
    
            bold_font = "auto";
            italic_font = "auto";
            bold_italic_font = "auto";
            

            cursor_shape = "beam";
            cursor_trail = 1;
            
            background_blur = 30;
        };
    };
}
