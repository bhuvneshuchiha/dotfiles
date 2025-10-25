return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				-- go = { "gofumpt", "gofmt", "goimports" },
				go = { "gofumpt", "goimports" },
				python = { "black" },
				ruby = { "rubyfmt" },
				eruby = { "erb_formatter" },
				typescript = { "prettierd", "prettier" },
				typescriptreact = { "prettierd", "prettier" },
				javascript = { "prettierd", "prettier" },
				javascriptreact = { "prettierd", "prettier" },
				css = { "prettierd", "prettier" },
				scss = { "prettierd", "prettier" },
				markdown = { "prettierd", "prettier" },
				html = { "prettierd", "prettier" },
				json = { "prettierd", "prettier" },
				yaml = { "prettierd", "prettier" },
				graphql = { "prettierd", "prettier" },
				md = { "prettierd", "prettier" },
				txt = { "prettierd", "prettier" },
			},
			-- Use the first available formatter in the list
			format_on_save = false,

			formatters = {
				prettierd = {
					inherit = true,
					prepend_args = { "--use-tabs" },
					append_args = { "--trailing-comma" },
					supports_multiple_files = false,
				},
				-- stylua = {
				-- 	args = { "--indent-width", "2", "--indent-type", "Tabs", "-" },
				-- },
				prettier = {
					inherit = true,
					prepend_args = { "--use-tabs" },
				},
				-- rubocop = {
				-- 	command = "bundle",
				-- 	args = { "exec", "rubocop", "-A", "--stdin", "$FILENAME" },
				-- },
			},
			-- Set global default to stop after the first available formatter
			format_after_save = {
				lsp_fallback = true,
			},
			stop_after_first = true,
		})
	end,
}
