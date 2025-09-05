return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")
		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")
		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				-- "ts_ls",
				-- "html",
				-- "cssls",
				"gopls",
				-- "clangd",
				-- "tailwindcss",
				-- "svelte",
				"lua_ls",
				-- "ruff",
				-- "jdtls",
				-- "pylsp",
				-- "graphql",
				-- "emmet_ls",
				-- "prismals",
			},
		})

		local vue_language_server_path = vim.fn.stdpath("data")
			.. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

		local vue_plugin = {
			name = "@vue/typescript-plugin",
			location = vue_language_server_path,
			languages = { "vue" },
			configNamespace = "typescript",
		}
		vim.lsp.config("vtsls", {
			settings = {
				vtsls = {
					tsserver = {
						globalPlugins = {
							vue_plugin,
						},
					},
				},
			},
			filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
		})

		vim.lsp.enable("vue_ls")
		vim.lsp.enable("vtsls")

		mason_tool_installer.setup({
			ensure_installed = {
				-- "prettier", -- prettier formatter
				-- "stylua",   -- lua formatter
				-- "isort",    -- python formatter
				-- "black",    -- python formatter
				-- "eslint_d",
			},
		})
	end,
}
