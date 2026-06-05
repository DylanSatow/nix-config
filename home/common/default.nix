# Shared base for the standalone home-manager configurations (server + WSL).
# Hosts that build through NixOS/nix-darwin use home/default.nix instead.
{...}: {
  imports = [
    ../theme.nix
    ./packages.nix
    ../apps/shell.nix
    ../apps/git.nix
    ../apps/helix.nix
    ../apps/nvim/nvim.nix
  ];

  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
}
