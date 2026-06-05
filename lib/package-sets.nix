# Shared package lists, consumed by both system modules (environment.systemPackages)
# and standalone home-manager modules (home.packages). Single source of truth so the
# server / WSL home configs no longer duplicate the host package lists.
#
# NOTE: zellij is intentionally excluded from cliTools — it is owned by programs.zellij
# in home/modules/shell.nix everywhere, and listing it here would collide in home configs.
# texliveFull is excluded from development — only the system hosts opt into it.
{pkgs}: {
  cliTools = [
    pkgs.unstable.lazygit
    pkgs.unstable.yazi
    pkgs.unstable.ripgrep
    pkgs.unstable.ripgrep-all
    pkgs.unstable.fzf
    pkgs.unstable.fd
    pkgs.unstable.gh

    pkgs.unstable.claude-code
    pkgs.unstable.gemini-cli

    pkgs.unstable.tree-sitter
  ];

  development = [
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
