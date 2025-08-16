{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    
    # C/C++ development tools
    gcc
    cmake
    pkg-config
    gdb
    valgrind
    
    # Go development tools
    delve
    
    # Rust development tools
    rustfmt
    clippy
    
    # Python development tools
    python3Packages.black
    python3Packages.flake8
    python3Packages.pip
  ];
}