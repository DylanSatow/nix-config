{ pkgs, ... }: {
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

        # NixOS utilities
        networkmanagerapplet
        dconf2nix

        # Gaming
        mangohud
        protonup

        # Containers
        docker
        docker-compose
        docker-client

        # Nvidia Development
        cudaPackages.cuda_nvcc
    ];
}
