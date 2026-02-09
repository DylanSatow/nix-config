{ pkgs, ... }:
{
  programs.steam.enable = true;
  environment.systemPackages = with pkgs.unstable; [
    # GUI Applications
    spotify
    obsidian
    discord
    vscode
    gnome-pomodoro
    surge-XT

    # Terminal
    kitty
    warp-terminal

    # NixOS utilities
    networkmanagerapplet
    dconf2nix

    # Gaming
    mangohud
    protonup-ng

    # Containers
    docker
    docker-compose
    docker-client

    # Nvidia Development
    cudaPackages.cuda_nvcc
  ];
}
