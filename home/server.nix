{ config, pkgs, ... }: {
  imports = [
    ./development.nix
    ./editors.nix
    ./terminal.nix
  ];

  home.username = "ubuntu";
  home.homeDirectory = "/home/ubuntu";

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

  programs.git = {
    enable = true;
    userName = "DylanSatow";
    userEmail = "dylansatow531@gmail.com";
  };
  
  programs.zsh.enable = true;
  programs.home-manager.enable = true;
  
  programs.lazygit = {
    enable = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.stateVersion = "25.05";
}