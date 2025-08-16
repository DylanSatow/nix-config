{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [

    # Terminal Utils
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
