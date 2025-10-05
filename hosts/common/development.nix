{ pkgs, ... } : {
    environment.systemPackages = with pkgs; [

        # Jetbrains Mono
        nerd-fonts.jetbrains-mono

        # Terminal utilities
        git
        nixpkgs-fmt
        direnv
        nnn
        neovide

        # Language runtimes
        nodejs
        python3
        go
        clang
        rustc
        cargo
        lua
        typescript

        # LSPs/Formatters
        lua-language-server
        stylua
        pyright
        clang-tools
        nil
        lua-language-server
        gopls

        # Telescope
        ripgrep
        fzf
        fd
        lazygit
    ];
}
