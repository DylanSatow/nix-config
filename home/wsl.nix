# dylanpc — Windows 11 + WSL Ubuntu, standalone home-manager (x86_64-linux, user "dylan").
# Nix package manager only (no NixOS). Built with: home-manager switch --flake ~/home/nix-config#dylan@dylanpc
{pkgs, ...}: {
  imports = [
    ./common.nix
    ./modules/kitty.nix
  ];

  home.username = "dylan";
  home.homeDirectory = "/home/dylan";

  # WSL's login shell is bash (recorded in /etc/passwd) and standalone
  # home-manager can't change it. Manage bash just enough to hop into the
  # zsh configured in shell.nix, so interactive terminals land in zsh and
  # ~/.zshrc (oh-my-zsh, aliases, zoxide's `z`) actually runs.
  programs.bash = {
    enable = true;
    initExtra = ''
      if [[ $- == *i* && -x ${pkgs.zsh}/bin/zsh ]]; then
        exec ${pkgs.zsh}/bin/zsh -l
      fi
    '';
  };

  # kitty runs through WSLg — install the nerd font so glyphs render.
  fonts.fontconfig.enable = true;
  home.packages = [pkgs.unstable.nerd-fonts.jetbrains-mono];
}
