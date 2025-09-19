{ config, pkgs, ... }: {
  imports = [
    ./default.nix
    ./development.nix
    ./editors.nix
    ./terminal.nix
  ];

  home.packages = with pkgs; [
    curl
    wget
    htop
    tmux
    tree
    unzip
    which
    file
    lsof
    
    # Development tools
    gcc
    gnumake
    pkg-config
    
    # Network tools
    nettools
    openssh
    
    # System tools  
    pciutils
    usbutils
    
    # AI tools
    unstable.claude-code
    unstable.gemini-cli
  ];

  programs.git.enable = true;
  programs.zsh.enable = true;
  programs.home-manager.enable = true;
}