{ pkgs, ... }: {
    environment.systemPackages = with pkgs; [
        # Core system utils 
        zip
        unzip
        gh

        lazygit

        # latex stuff 
        texliveFull

        btop
        alacritty

        unstable.helix

        gh

        # AI tools
        unstable.claude-code
        unstable.gemini-cli

        # cli tools
        zellij
        yazi
        zoxide
        tdf
        unstable.bootdev-cli

        # Dev Stuff
        # python
        python3
        pyright
        # nix 
        nil
        alejandra
        # rust
        rustc
        cargo
        rust-analyzer
        # go
        go
        gopls 
        # c
        gcc
        # markdown
        markdown-oxide 
    ];
}
