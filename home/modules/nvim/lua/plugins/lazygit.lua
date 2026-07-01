-- Stop snacks.nvim from generating its own lazygit theme from nvim highlights
-- (it rendered dark/off inside neovim). With `configure = false`, the in-editor
-- lazygit uses the nix-managed catppuccin config (see modules/lazygit.nix), so it
-- looks identical to standalone lazygit. The nvim-remote editPreset lives in that
-- config, so opening files back in nvim still works.
return {
  "folke/snacks.nvim",
  opts = {
    lazygit = {
      configure = false,
    },
  },
}
