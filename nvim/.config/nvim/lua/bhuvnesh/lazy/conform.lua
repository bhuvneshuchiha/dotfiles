-- return {
-- 	"stevearc/conform.nvim",
-- 	opts = {},
-- 	config = function()
-- 		require("conform").setup({
-- 			formatters_by_ft = {
-- 				lua = { "stylua" },
-- 				go = { "goimports", "gofmt" },
-- 				python = { "black" },
-- 				typescript = { { "prettierd", "prettier" } },
-- 				typescriptreact = { { "prettierd", "prettier" } },
-- 				javascript = { { "prettierd", "prettier" } },
-- 				javascriptreact = { { "prettierd", "prettier" } },
-- 			},
-- 		})
-- 	end,
-- }

return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "goimports", "gofmt" },
				python = { "black" },
				typescript = { "prettierd", "prettier" },
				typescriptreact = { "prettierd", "prettier" },
				javascript = { "prettierd", "prettier" },
				javascriptreact = { "prettierd", "prettier" },
			},
			-- Use the first available formatter in the list
			format_on_save = false,
			formatters = {
				prettierd = {
					prepend_args = { "--tab-width", "4" },
				},
				prettier = {
					prepend_args = { "--tab-width", "4" },
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
