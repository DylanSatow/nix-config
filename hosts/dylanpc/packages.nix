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
        vscode

        # Core system utils 
        zip
        unzip
        dconf2nix

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

        # cli tools
        zellij
        lazygit
        yazi

        # Dev Stuff
        # python
        python3
        pyright
        # nix 
        nil
        alejandra
        # rust
        rustc
        rust-analyzer
        # go
        go
        gopls 
        # c
        gcc
                
    ];
}
