# Shells: fish is the primary interactive shell (launched by wezterm and by the
# bash→fish hop on Linux). zsh is kept as a configured fallback so non-wezterm
# terminals (Terminal.app, etc.) that land in the system zsh still feel nice.
# Aliases are defined once and shared by both. Standalone home-manager can't
# change the OS login shell; direnv/zoxide enable integration for both shells.
{
  pkgs,
  lib,
  isDarwin,
  isWsl,
  isServer,
  ...
}: let
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
in {
  programs.fish = {
    enable = true;
    inherit shellAliases;

    # Standalone home-manager doesn't install nix's fish PATH hook into
    # /etc/fish/conf.d, so a GUI-launched fish (wezterm via launchd on mac)
    # starts without the nix profile on PATH — nvim, zoxide, etc. go missing.
    # Source nix's own fish hook to put the profile on PATH. It self-guards
    # against double-sourcing, so it's a no-op when bash already ran it on the
    # Linux bash→fish hop.
    loginShellInit = ''
      if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
          source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
      end
    '';
  };

  programs.zsh = {
    enable = true;
    inherit shellAliases;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };

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
