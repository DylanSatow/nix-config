# Interactive shell: fish. Standalone home-manager can't change the OS login
# shell, so on Linux hosts (WSL, server) bash hops into fish; on mac, wezterm's
# default_prog launches fish directly. direnv/zoxide use fish integration (on by
# default in home-manager). Catppuccin themes fish automatically via theme.nix.
{
  pkgs,
  lib,
  isDarwin,
  isWsl,
  isServer,
  ...
}: {
  programs.fish = {
    enable = true;

    shellAliases = {
      nrb =
        if isDarwin
        then "home-manager switch --flake ~/home/nix-config#dylan@dylanmac"
        else if isWsl
        then "home-manager switch --flake ~/home/nix-config#dylan@dylanpc"
        else if isServer
        then "home-manager switch --flake ~/nix-config#ubuntu@dylanserver"
        else "echo 'nrb: unknown host'";
      cld = "claude --dangerously-skip-permissions";
      vim = "nvim";
      nv = "nvim";
      y = "yazi";
      lg = "lazygit";
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.zellij = {
    enable = true;
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

  programs.zoxide.enable = true;

  # Linux login shells are bash (recorded in /etc/passwd) and standalone
  # home-manager can't chsh. Manage bash just enough to exec into fish so
  # interactive terminals land in the fish configured above.
  programs.bash = lib.mkIf (!isDarwin) {
    enable = true;
    initExtra = ''
      if [[ $- == *i* && -x ${pkgs.fish}/bin/fish ]]; then
        exec ${pkgs.fish}/bin/fish -l
      fi
    '';
  };
}
