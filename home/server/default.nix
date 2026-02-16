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

  programs.zsh.initExtra = ''
    export PATH="/home/ubuntu/.npm-global/bin:$PATH"
  '';

  programs.home-manager.enable = true;
}
