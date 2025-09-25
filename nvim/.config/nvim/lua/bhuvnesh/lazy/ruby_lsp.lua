return {
	"adam12/ruby-lsp.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"neovim/nvim-lspconfig",
	},
	config = true,
	opts = {
		lspconfig = {
			init_options = {
				formatter = "rubyfmt",
				linters = {},
			},
		},
	},
}
