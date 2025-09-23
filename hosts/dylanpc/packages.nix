{ pkgs, ... }: {
    # Steam Settings
    programs.steam.enable = true;
    programs.steam.gamescopeSession.enable = true;
    programs.gamemode.enable = true;

    environment.sessionVariables = {
            STEAM_EXTRA_COMPAT_TOOLS_PATH = 
                "/home/dylan/.steam/root/compatibilitytools.d";
    };

    # To enable gamemode, add the following to launch options for steam games
    # gamemoderun %command%
    # mangohud %command%
    # gamescope %command%

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

        # Core system utils 
        zip
        unzip

        unstable.helix

        # Tutorials 
        bootdev-cli

        # Gaming
        mangohud 
        protonup

        # Gpu Programming
        cudaPackages.cuda_nvcc
    ];
}
