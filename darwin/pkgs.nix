{ pkgs, ... }: {
  environment.systemPackages = [
    pkgs.vim
    pkgs.neovim
    pkgs.neovide
    pkgs.nixpkgs-fmt
    pkgs.direnv
    pkgs.nnn

    # Unstable
    pkgs.unstable.claude-code
  ];
}