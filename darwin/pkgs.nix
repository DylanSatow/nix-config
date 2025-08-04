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

    # Unstable
    pkgs.unstable.claude-code
  ];
}