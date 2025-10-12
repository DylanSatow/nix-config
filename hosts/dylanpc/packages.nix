{ pkgs, ... }: {
    environment.systemPackages = with pkgs; [
        spotify
        obsidian
        discord
        docker
        docker-compose
        docker-client
        btop
        networkmanagerapplet
        surge-XT 
        alacritty
        kitty

        # Core system utils 
        zip
        unzip

        unstable.helix

        # Gaming
        mangohud 
        protonup

        # Gpu Programming
        cudaPackages.cuda_nvcc

        gh

        # AI tools
        unstable.claude-code
        unstable.gemini-cli
    ];
}
