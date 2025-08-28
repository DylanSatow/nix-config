{ pkgs, ... }: {
    environment.systemPackages = with pkgs; [
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
        gopls
        rust-analyzer
        typescript-language-server
        lua-language-server
        nil
        clang-tools
        vscode-langservers-extracted
        yaml-language-server
        bash-language-server
        ruff

        # AI tools
        unstable.claude-code
        unstable.gemini-cli
    ];
}
