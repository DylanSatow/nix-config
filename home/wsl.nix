# dylanpc — Windows 11 + WSL Ubuntu, standalone home-manager (x86_64-linux, user "dylan").
# Nix package manager only (no NixOS). Built with: home-manager switch --flake ~/home/nix-config#dylan@dylanpc
{pkgs, ...}: {
  imports = [
    ./common.nix
    ./modules/wezterm.nix
  ];

  home.username = "dylan";
  home.homeDirectory = "/home/dylan";

  # wezterm runs through WSLg — install the nerd font so glyphs render.
  # (The bash→fish hop lives in shell.nix, gated on non-darwin hosts.)
  fonts.fontconfig.enable = true;
  home.packages = [pkgs.unstable.nerd-fonts.jetbrains-mono];
}
