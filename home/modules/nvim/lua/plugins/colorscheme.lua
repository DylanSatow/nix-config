-- Catppuccin Mocha, replacing LazyVim's default tokyonight. Previously this came
-- from a nix-provided vimPlugin; now lazy.nvim fetches it from git.
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "mocha",
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
