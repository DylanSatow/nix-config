# dylanmac — Apple Silicon mac, standalone home-manager (user "dylan").
# Nix manages the CLI/dev toolchain and dotfiles only. GUI apps (kitty, VS Code, etc.)
# are installed by hand; we just link their config. Built with:
#   home-manager switch --flake ~/home/nix-config#dylan@dylanmac
{pkgs, ...}: {
  imports = [
    ./common.nix
    ./modules/kitty.nix
    ./modules/vscode.nix
  ];

  home.username = "dylan";
  home.homeDirectory = "/Users/dylan";

  # kitty.conf references this font; home-manager links it into ~/Library/Fonts.
  home.packages = [pkgs.unstable.nerd-fonts.jetbrains-mono];
}
