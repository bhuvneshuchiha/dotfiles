return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				-- go = { "gofmt" },
				go = { "gofumpt" },
				ruby = { "rubyfmt" },
				eruby = { "erb_formatter" },
				python = { "black" },
				-- typescript = { "prettierd", "prettier" },
				-- typescriptreact = { "prettierd", "prettier" },
				-- javascript = { "prettierd", "prettier" },
				-- javascriptreact = { "prettierd", "prettier" },
				--             json = { "prettierd" },
				--             jsonc = { "prettierd" },
				-- html = { "prettierd", "prettier" },
				-- css = { "prettierd", "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
                json = { "prettierd" },
                jsonc = { "prettierd" },
				html = { "prettier" },
				css = { "prettier" },
			},
			-- Use the first available formatter in the list
			format_on_save = false,

			formatters = {
				prettierd = {
					inherit = true,
					prepend_args = { "--use-tabs" },
                    -- prepend_args = { "--tab-width", "2", "--use-tabs=false" },
					append_args = { "--trailing-comma" },
					supports_multiple_files = false,
				},
				prettier = {
					inherit = true,
                    -- prepend_args = { "--tab-width", "2", "--use-tabs=false" },
					prepend_args = { "--use-tabs" },
				},
			},
			-- Set global default to stop after the first available formatter
			format_after_save = {
				lsp_fallback = true,
			},
			-- This is the new way to mimic `{ { "a", "b" } }` behavior:
			-- conform will pick the first available
			-- formatter in the list per filetype and stop
			-- if one succeeds.
			-- Global setting:
			stop_after_first = true,
		})
	end,
}
