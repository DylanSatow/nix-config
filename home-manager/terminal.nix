{ config, pkgs, ... }: {
  programs.zsh = {
    enable = true;

    oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
    };

    shellAliases = {
      nrb = "sudo darwin-rebuild switch --flake /Users/dylan/home/nix-config#dylanix";
    };

    # Change to ~/home directory for new terminal sessions
    # but skip if we're in a specific working directory (e.g., VS Code terminal)
    initContent = ''
      # Override cd to go to /Users/dylan/home when no arguments provided
      function cd() {
        if [[ $# -eq 0 ]]; then
          builtin cd "/Users/dylan/home"
        else
          builtin cd "$@"
        fi
      }
      
      # Only change directory if we're in the default home directory
      # and not already in a subdirectory (preserves editor terminal behavior)
      if [[ "$PWD" == "$HOME" && -z "$VSCODE_INJECTION" ]]; then
        if [[ -d "$HOME/home" ]]; then
          cd "$HOME/home"
        fi
      fi
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
        # Fonts
        font_family = "JetBrainsMono Nerd Font";
        bold_font = "auto";
        italic_font = "auto";
        bold_italic_font = "auto";
        font_size = 19.0;

        # Cursor
        cursor_shape = "beam";
        cursor_trail = 1;
        background_opacity = 1;
        background_blur = 30;
    };
  };
}