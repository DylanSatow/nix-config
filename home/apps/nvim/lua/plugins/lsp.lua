return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                nil_ls = { mason = false },
                gopls = { mason = false },
                pyright = { mason = false },
                clangd = { mason = false },
                markdown_oxide = { mason = false },
            },
        },
    },
    {
        "mason-org/mason.nvim",
        opts = {
            ensure_installed = {},
        },
    },
    -- {
    --     "neovim/nvim-lspconfig",
    --     opts = function(_, opts)
    --         for server, server_opts in pairs(opts.servers) do
    --             server_opts.mason = false
    --         end
    --     end,
    -- },
    {
        "stevearc/conform.nvim",
        opts = {},
    },
}
