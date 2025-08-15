-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Quick open terminal with Claude Code
vim.keymap.set("n", "<leader>tc", function()
  vim.cmd("split")
  vim.cmd("terminal")
  vim.cmd("startinsert")
  vim.defer_fn(function()
    local buf = vim.api.nvim_get_current_buf()
    if vim.b[buf].terminal_job_id then
      vim.fn.chansend(vim.b[buf].terminal_job_id, "claude code\r")
    end
  end, 100)
end, { desc = "Open terminal with Claude Code" })
