{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    vim
    neovim
    git
    nixpkgs-fmt
    direnv
    nnn
    neovide
    fzf
    ripgrep
    fd
    lazygit

    unstable.claude-code
    unstable.gemini-cli
  ];
}
