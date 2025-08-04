-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Ensure nix-config directory stays as working directory in neovide
if vim.g.neovide then
  vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    callback = function()
      local current_dir = vim.fn.getcwd()
      local nix_config_dir = "/Users/dylan/home/nix-config"
      
      -- Check if we should change to nix-config directory
      local should_change = false
      
      -- Check if we're already in nix-config directory
      if string.find(current_dir, nix_config_dir) then
        should_change = true
      -- Check if we opened a file from nix-config directory  
      elseif vim.fn.argc() > 0 and string.find(vim.fn.argv(0), nix_config_dir) then
        should_change = true
      -- Check if current directory is root (likely launched from hotkey)
      elseif current_dir == "/" then
        should_change = true
      end
      
      if should_change then
        vim.api.nvim_set_current_dir(nix_config_dir)
      end
    end,
  })
end
