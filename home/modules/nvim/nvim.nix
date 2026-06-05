# Neovim: nix installs the binary plus the build prerequisites that lazy.nvim,
# nvim-treesitter, and Mason need at runtime. Everything else — plugins, LSP
# servers, formatters — is fetched/managed at runtime by lazy + Mason. The Lua
# config lives in this repo and is symlinked read-only; lazy-lock.json and
# ~/.local/share/nvim/mason/ stay writable outside the linked dirs.
{pkgs, ...}: {
  programs.neovim = {
    enable = true;

    # LazyVim + Mason need neither the Ruby nor the Python3 provider. These match the
    # 26.05 defaults; set explicitly to silence the default-changed warnings.
    withRuby = false;
    withPython3 = false;

    # Runtime toolchain for lazy.nvim (git), treesitter parser compilation
    # (gcc/make), Mason installers (node/npm, unzip). ripgrep/fd/tree-sitter
    # come from the shared CLI package set and are already on PATH.
    extraPackages = [
      pkgs.git
      pkgs.gcc
      pkgs.gnumake
      pkgs.unstable.nodejs
      pkgs.unzip
    ];
  };

  # LazyVim config — see https://github.com/LazyVim/starter/tree/main/lua
  xdg.configFile."nvim/lua".source = ./lua;
  xdg.configFile."nvim/init.lua".source = ./init.lua;
  xdg.configFile."nvim/stylua.toml".source = ./stylua.toml;
}
