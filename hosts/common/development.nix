{ pkgs, ... }:

{
  environment.systemPackages = with pkgs.unstable; [
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
    pkgs.valgrind-light

    # Markdown
    markdown-oxide

    # Tex
    texliveFull
  ];
}
