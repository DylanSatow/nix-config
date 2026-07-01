# The CLI + development toolchain installed on every host. zellij is intentionally
# absent — it is owned by programs.zellij in shell.nix, and listing it here would
# collide. lazygit is likewise absent — owned by programs.lazygit in lazygit.nix so
# home-manager manages its config (and catppuccin themes it).
# Most packages use pkgs.unstable; migrate to stable where a newer version
# isn't specifically needed (see .claude/architecture.md tech debt).
#
# NOTE: the language servers below (nil, pyright, rust-analyzer, gopls, clang-tools,
# markdown-oxide, golangci-lint-langserver) are here for HELIX, which reads LSPs off
# PATH. Neovim does NOT use these — it installs its own via Mason. Don't remove them
# expecting nvim to cover Helix.
{pkgs, ...}: {
  home.packages = [
    # CLI tools
    pkgs.unstable.yazi
    pkgs.unstable.ripgrep
    pkgs.unstable.ripgrep-all
    pkgs.unstable.fzf
    pkgs.unstable.fd
    pkgs.unstable.gh
    pkgs.unstable.claude-code
    pkgs.unstable.gemini-cli
    pkgs.unstable.tree-sitter

    # Nix
    pkgs.unstable.nil
    pkgs.unstable.alejandra

    # Python
    pkgs.unstable.python3
    pkgs.unstable.ruff
    pkgs.unstable.pyright
    pkgs.unstable.poetry
    pkgs.unstable.uv

    # Javascript
    pkgs.unstable.pnpm

    # Rust
    pkgs.unstable.rustc
    pkgs.unstable.cargo
    pkgs.unstable.rust-analyzer

    # Go
    pkgs.unstable.go
    pkgs.unstable.gopls
    pkgs.unstable.delve
    pkgs.unstable.golangci-lint
    pkgs.unstable.golangci-lint-langserver

    # C
    pkgs.unstable.gcc
    pkgs.unstable.clang-tools

    # Markdown
    pkgs.unstable.markdown-oxide
  ];
}
