{ pkgs, ... }:

{
  environment.systemPackages = with pkgs.unstable; [
    zellij
    lazygit
    yazi
    ripgrep
    ripgrep-all
    fzf
    fd
    gh

    claude-code
    gemini-cli

    tree-sitter
  ];
}
