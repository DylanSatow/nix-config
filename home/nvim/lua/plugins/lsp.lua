return {
    {
        "neovim/nvim-lspconfig",
        ---@class PluginLspOpts
        opts = {
            ---@type lspconfig.options
            servers = {
                -- pyright will be automatically installed with mason and loaded with lspconfig
                pyright = { mason = false },
                clangd = { mason = false },
                nil_ls = { mason = false },
                lua_ls = { mason = false },
                gopls = { mason = false },
            },
        },
    },
    {
        "neovim/nvim-treesitter",
        opts = {
            ensure_installed = {
                "nix",
            }
        }
    },
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
            formatters_by_ft = {
                nix = { "nixfmt" },
            },
        },
    },
}
