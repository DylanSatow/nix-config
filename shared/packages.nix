{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    vim
    neovim
    git
    nixpkgs-fmt
    direnv

    unstable.claude-code
  ];
}