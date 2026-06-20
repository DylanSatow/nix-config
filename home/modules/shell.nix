{
  isDarwin,
  isWsl,
  isServer,
  ...
}: {
  programs.zsh = {
    enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
    };
    shellAliases = {
      nrb =
        if isDarwin
        then "home-manager switch --flake ~/home/nix-config#dylan@dylanmac"
        else if isWsl
        then "home-manager switch --flake ~/home/nix-config#dylan@dylanpc"
        else if isServer
        then "home-manager switch --flake ~/home/nix-config#ubuntu@dylanserver"
        else "echo 'nrb: unknown host'";
      cld = "claude --dangerously-skip-permissions";
      vim = "nvim";
      nv = "nvim";
      y = "yazi";
      lg = "lazygit";
    };

    # Re-assert a steady vertical-bar cursor before every prompt. nvim/helix
    # reset the terminal cursor to its default on exit, and Terminal.app can't
    # restore the prior shape, so we set it ourselves each time we return to a
    # prompt. DECSCUSR: \e[6 q = steady bar (matches kitty's cursor_shape).
    initContent = ''
      autoload -Uz add-zsh-hook
      _set_cursor_beam() { printf '\e[6 q' }
      add-zsh-hook precmd _set_cursor_beam
    '';
  };
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.zellij = {
    enable = true;
    # enableZshIntegration = true;
    settings = {
      keybinds = {
        normal = {
          "bind \"Alt q\"" = {
            CloseFocus = {};
          };
          "bind \"Alt t\"" = {
            NewTab = {};
          };
        };
      };
      show_startup_tips = false;
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
