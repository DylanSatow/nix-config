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
    username = "ubuntu";
    homeDirectory = "/home/ubuntu";
    stateVersion = "25.05";
  };

  programs.home-manager.enable = true;
}
