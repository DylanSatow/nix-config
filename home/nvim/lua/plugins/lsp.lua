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
            },
        },
    },
}
