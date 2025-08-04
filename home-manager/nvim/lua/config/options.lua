-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Disable autochdir to prevent working directory from changing when opening files
vim.opt.autochdir = false

-- Set font for neovide GUI
if vim.g.neovide then
  vim.opt.guifont = "JetBrainsMono Nerd Font:h16"
end

-- Enable terminal clearing
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    -- unbind <c-l> in terminal
    vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", "<C-l>", { noremap = true, silent = true })
  end
})