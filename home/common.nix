# Shared base imported by every host (mac, WSL, server). Pulls in the theme, the
# package sets, and the always-on app modules. Host files add their own extras.
{...}: {
  imports = [
    ./modules/theme.nix
    ./modules/packages.nix
    ./modules/shell.nix
    ./modules/lazygit.nix
    ./modules/starship.nix
    ./modules/zellij.nix
    ./modules/git.nix
    ./modules/helix.nix
    ./modules/nvim/nvim.nix
  ];

  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
}
