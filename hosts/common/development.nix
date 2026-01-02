{ pkgs, ... }:

{
  environment.systemPackages = with pkgs.unstable; [
    # Nix
    nil
    alejandra

    # Python
    python3
    pyright

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
  ];
}
