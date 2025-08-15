{ pkgs, ... }: {
  environment.systemPackages = [
    pkgs.go

    pkgs.vim
    pkgs.neovim
    pkgs.neovide
    pkgs.nixpkgs-fmt
    pkgs.direnv
    pkgs.nnn
    pkgs.skhd

    pkgs.unstable.claude-code
  ];
}