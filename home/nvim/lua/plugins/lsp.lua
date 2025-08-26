return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Nix-managed language servers
        pyright = {},
        nil_ls = {},
        gopls = {},
        rust_analyzer = {},
        lua_ls = {},
        tsserver = {},
        yamlls = {},
        bashls = {},
      },
    },
  },
}