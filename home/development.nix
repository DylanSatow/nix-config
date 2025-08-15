{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    
    gcc
    cmake
    pkg-config
    
    nil
    pyright
    typescript-language-server
    gopls
    rust-analyzer
    clang-tools
    lua-language-server
    vscode-langservers-extracted
    yaml-language-server
    bash-language-server
  ];
}