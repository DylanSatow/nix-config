{ pkgs, ... }:

{
  home.packages = with pkgs.unstable; [
    # CLI tools (mirrors hosts/common/cli-tools.nix)
    zellij
    lazygit
    yazi
    ripgrep
    ripgrep-all
    fzf
    fd
    gh
    claude-code
    gemini-cli
    tree-sitter

    # Development (mirrors hosts/common/development.nix)

    # Nix
    nil
    alejandra

    # Python
    python3
    ruff
    pyright
    poetry
    uv

    # Javascript
    pnpm

    # Rust
    rustc
    cargo
    rust-analyzer

    # Go
    go
    gopls
    delve
    golangci-lint
    golangci-lint-langserver

    # C
    gcc
    clang-tools

    # Markdown
    markdown-oxide
  ];
}
