{ ... }:

{
  imports = [
    ./packages.nix
    ../apps/shell.nix
    ../apps/git.nix
    ../apps/helix.nix
    ../apps/nvim/nvim.nix
  ];

  home = {
    username = "dylan";
    homeDirectory = "/home/dylan";
    stateVersion = "25.05";
  };

  programs.home-manager.enable = true;
}
