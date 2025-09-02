{ pkgs, ... } : {
    environment.systemPackages = with pkgs; [

        # Jetbrains Mono
        nerd-fonts.jetbrains-mono

        # Terminal utilities
        vim
        neovim
        git
        nixpkgs-fmt
        direnv
        nnn
        neovide
        fzf
        ripgrep
        fd
        lazygit

        # Language runtimes
        nodejs
        python3
        go
        clang
        rustc
        cargo
        lua
        typescript

        # Language servers
        pyright
        clang-tools
        nil
        lua-language-server
        gopls
    ];
}
