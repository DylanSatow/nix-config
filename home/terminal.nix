{ config, pkgs, ... }: {
  programs.zsh = {
    enable = true;

    oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
    };

    shellAliases = if pkgs.stdenv.isDarwin then {
      nrb = "sudo darwin-rebuild switch --flake /Users/dylan/home/nix-config#dylanix";
    } else {
      nrb = "sudo nixos-rebuild switch --flake /home/dylan/home/nix-config#dylanxps";
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
        bold_font = "auto";
        italic_font = "auto";
        bold_italic_font = "auto";
        font_size = 19.0;

        cursor_shape = "beam";
        cursor_trail = 1;
        background_opacity = 1;
        background_blur = 30;
    };
  };
}