{
  isDarwin,
  isDesktop,
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
        then "darwin-rebuild switch --flake ~/nix-config#dylanmac"
        else if isDesktop
        then "sudo nixos-rebuild switch --flake ~/nix-config#nixos-pc"
        else if isWsl
        then "home-manager switch --flake ~/nix-config#dylan@dylanpc"
        else if isServer
        then "home-manager switch --flake ~/nix-config#ubuntu@dylanserver"
        else "echo 'nrb: unknown host'";
      vim = "nvim";
      nv = "nvim";
      y = "yazi";
      lg = "lazygit";
    };
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
