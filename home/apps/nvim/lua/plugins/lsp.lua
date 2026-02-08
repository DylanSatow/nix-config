return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				nil_ls = {},
				gopls = {},
				pyright = {},
				clangd = {},
			},
		},
	},
}
