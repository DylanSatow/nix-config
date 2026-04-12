{ pkgs, ... }:
{
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  services.tailscale.enable = true;

  environment.systemPackages = with pkgs.unstable; [
    # GUI Applications
    # spotify
    obsidian
    discord
    vscode
    gnome-pomodoro
    surge-XT
    keymapp

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
