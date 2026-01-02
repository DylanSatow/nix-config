{ pkgs, ... }:

{
  environment.systemPackages = with pkgs.unstable; [
    # editors
    helix
    neovim

    zellij
    lazygit
    yazi
    ripgrep
    ripgrep-all
    fzf
    fd
    gh

    # AI tools
    claude-code
    gemini-cli
  ];
}
