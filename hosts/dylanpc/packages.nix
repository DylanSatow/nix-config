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
        gnome-pomodoro

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
        docker
        ripgrep
        ripgrep-all

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
        cargo
        # go
        go
        golangci-lint-langserver
        delve
        golangci-lint
        gopls 
        # c
        gcc
        clang-tools                
    ];
}
