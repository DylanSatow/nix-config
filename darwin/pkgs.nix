{ pkgs, ... }: {
  environment.systemPackages = [
    pkgs.vim
    pkgs.neovim
    pkgs.neovide
    pkgs.nixpkgs-fmt

    # Unstable
    pkgs.unstable.claude-code
  ];
}