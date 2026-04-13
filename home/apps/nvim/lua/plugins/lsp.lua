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
        "neovim/nvim-lspconfig",
        opts = function(_, opts)
            for _, server_opts in pairs(opts.servers) do
                if type(server_opts) == "table" then
                    server_opts.mason = false
                end
            end
        end,
    },
    {
        "mason-org/mason.nvim",
        config = function()
            -- no-op: all tools managed by nix
            require("mason").setup({ registries = {} })
        end,
    },
    {
        "mason-org/mason-lspconfig.nvim",
        config = function() end,
    },
    {
        "stevearc/conform.nvim",
        opts = {},
    },
}
