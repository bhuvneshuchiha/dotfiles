-- return {
-- 	"neovim/nvim-lspconfig",
-- 	dependencies = {
-- 		"stevearc/conform.nvim",
-- 		"williamboman/mason.nvim",
-- 		"williamboman/mason-lspconfig.nvim",
-- 		"hrsh7th/cmp-nvim-lsp",
-- 		"hrsh7th/cmp-buffer",
-- 		"hrsh7th/cmp-path",
-- 		"hrsh7th/cmp-cmdline",
-- 		"hrsh7th/nvim-cmp",
-- 		"L3MON4D3/LuaSnip",
-- 		"saadparwaiz1/cmp_luasnip",
-- 		"j-hui/fidget.nvim",
-- 	},
-- 	config = function()
-- 		require("conform").setup({
-- 			formatters_by_ft = {},
-- 		})
-- 		local cmp = require("cmp")
-- 		local cmp_lsp = require("cmp_nvim_lsp")
-- 		local capabilities = vim.tbl_deep_extend(
-- 			"force",
-- 			{},
-- 			vim.lsp.protocol.make_client_capabilities(),
-- 			cmp_lsp.default_capabilities()
-- 		)
--
-- 		require("fidget").setup({})
-- 		require("mason").setup()
-- 		require("mason-lspconfig").setup({
-- 			ensure_installed = {
-- 				"lua_ls",
-- 				"gopls",
-- 			},
-- 			handlers = {
-- 				function(server_name) -- default handler (optional)
-- 					require("lspconfig")[server_name].setup({
-- 						capabilities = capabilities,
-- 					})
-- 				end,
--
-- 				zls = function()
-- 					local lspconfig = require("lspconfig")
-- 					lspconfig.zls.setup({
-- 						root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
-- 						settings = {
-- 							zls = {
-- 								enable_inlay_hints = true,
-- 								enable_snippets = true,
-- 								warn_style = true,
-- 							},
-- 						},
-- 					})
-- 					vim.g.zig_fmt_parse_errors = 0
-- 					vim.g.zig_fmt_autosave = 0
-- 				end,
--
-- 				["lua_ls"] = function()
-- 					local lspconfig = require("lspconfig")
-- 					lspconfig.lua_ls.setup({
-- 						capabilities = capabilities,
-- 						settings = {
-- 							Lua = {
-- 								format = {
-- 									enable = true,
-- 									-- Put format options here
-- 									-- NOTE: the value should be STRING!!
-- 									defaultConfig = {
-- 										indent_style = "space",
-- 										indent_size = "2",
-- 									},
-- 								},
-- 							},
-- 						},
-- 					})
-- 				end,
-- 			},
-- 		})
--
-- 		local cmp_select = { behavior = cmp.SelectBehavior.Select }
--
-- 		-- For VS code like snippets --
-- 		-- local luasnip = require("luasnip")
-- 		-- require("luasnip.loaders.from_vscode").lazy_load()
-- 		-- luasnip.config.setup({})
-- 		-- For VS code like snippets --
--
-- 		cmp.setup({
-- 			snippet = {
-- 				expand = function(args)
-- 					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
-- 				end,
-- 			},
-- 			-- preselect = cmp.PreselectMode.None,
-- 			experimental = {
-- 				-- ghost_text = true,
-- 			},
--
-- 			mapping = cmp.mapping.preset.insert({
-- 				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
-- 				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
-- 				["<C-b>"] = cmp.mapping.scroll_docs(-4),
-- 				["<C-f>"] = cmp.mapping.scroll_docs(4),
-- 				["<C-Space>"] = cmp.mapping.complete({}),
-- ["<Tab>"] = cmp.mapping.confirm({ select = true }), -- Autocompletion on Tab
-- 				["<CR>"] = cmp.mapping.confirm({
-- 					behavior = cmp.ConfirmBehavior.Replace,
-- 					select = false, --Set true to make enter key select the first Autocompletion
-- 				}),
-- 			}),
-- 			sources = cmp.config.sources({
-- 				{ name = "copilot", group_index = 2 },
-- 				{ name = "nvim_lsp" },
-- 				{ name = "luasnip" }, -- For luasnip users.
-- 			}, {
-- 				{ name = "buffer" },
-- 			}),
-- 		})
--
-- 		vim.diagnostic.config({
-- 			-- update_in_insert = true,
-- 			-- underline = false,
-- 			float = {
-- 				focusable = false,
-- 				style = "minimal",
-- 				border = "rounded",
-- 				source = "always",
-- 				header = "",
-- 				prefix = "",
-- 			},
-- 		})
-- 	end,
-- }

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"stevearc/conform.nvim",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
	},

	config = function()
		require("conform").setup({
			formatters_by_ft = {},
		})
		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		require("fidget").setup({})
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				-- "ts_ls",
				"gopls",
				-- "pyright"
			},

			handlers = {
				function(server_name) -- default handler (optional)
					vim.notify("Setting up LSP: " .. server_name, vim.log.levels.WARN)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,

				zls = function()
					local lspconfig = require("lspconfig")
					lspconfig.zls.setup({
						root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
						settings = {
							zls = {
								enable_inlay_hints = true,
								enable_snippets = true,
								warn_style = true,
							},
						},
					})
					vim.g.zig_fmt_parse_errors = 0
					vim.g.zig_fmt_autosave = 0
				end,
				["ruff"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.ruff.setup({
						init_options = {
							settings = {
								args = {}, -- optional args like "--line-length=100"
							},
						},
					})
				end,

				["ruby_lsp"] = function()
					local lspconfig = require("lspconfig")

					lspconfig.ruby_lsp.setup({
						cmd = { "bundle", "exec", "ruby-lsp" },
						capabilities = capabilities,
					})
				end,

				-- ["ts_ls"] = function()
				-- 	local lspconfig = require("lspconfig")
				-- 	lspconfig.ts_ls.setup({
				-- 		capabilities = capabilities,
				-- 		single_file_support = true,
				-- 	})
				-- end,

				["pyright"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.pyright.setup({
						capabilities = capabilities,
						-- settings = {
						-- 	python = {
						-- 		analysis = {
						-- 			typeCheckingMode = "off", -- Turn off type checking
						-- 			diagnosticSeverityOverrides = {
						-- 				reportGeneralTypeIssues = "none",
						-- 				reportOptionalSubscript = "none",
						-- 				reportOptionalMemberAccess = "none",
						-- 				reportPrivateImportUsage = "none",
						-- 				reportUndefinedVariable = "none",
						-- 				reportUnusedImport = "none",
						-- 				reportUnusedVariable = "none",
						-- 			},
						-- 		},
						-- 	},
						-- },
					})
				end,
				["pylsp"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.pylsp.setup({
						capabilities = capabilities,
						settings = {
							pylsp = {
								plugins = {
									pycodestyle = { enabled = false },
									pyflakes = { enabled = false },
									mccabe = { enabled = false },
									pylint = { enabled = false },
									autopep8 = { enabled = false },
									yapf = { enabled = false },
									isort = { enabled = false },
									black = { enabled = false },
									pyls_isort = { enabled = false },
								},
							},
						},
						handlers = {
							["textDocument/publishDiagnostics"] = vim.lsp.with(
								vim.lsp.diagnostic.on_publish_diagnostics,
								{
									severity_limit = "Error",
								}
							),
						},
					})
				end,

				["tailwindcss"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.tailwindcss.setup({
						capabilities = capabilities,
						filetypes = {
							"html",
							"css",
							"scss",
							"javascript",
							"javascriptreact",
							"typescript",
							"typescriptreact",
							"vue",
							"svelte",
						},
						settings = {
							tailwindCSS = {
								experimental = {
									classRegex = {
										"tw`([^`]*)",
										'tw="([^"]*)',
										'tw={"([^"}]*)',
										"tw\\.\\w+`([^`]*)",
										"tw\\(.*?\\)`([^`]*)",
									},
								},
							},
						},
					})
				end,
				["lua_ls"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								format = {
									enable = true,
									-- Put format options here
									-- NOTE: the value should be STRING!!
									defaultConfig = {
										indent_style = "space",
										indent_size = "2",
									},
								},
							},
						},
					})
				end,
			},
		})

		-- to just select and not changing the buffer as you scroll through the list
		local cmp_select = { behavior = cmp.SelectBehavior.Select }
		-- to select and change the buffer as you scroll through the list
		-- local cmp_select = { behavior = cmp.SelectBehavior.Insert}

		cmp.setup({
			-- preselect = cmp.PreselectMode.None,
			-- completion = {
			-- 	completeopt = "menu,menuone,noinsert,noselect",
			-- },
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = "copilot", group_index = 2 },
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- For luasnip users.
			}, {
				{ name = "buffer" },
			}),
		})

		vim.diagnostic.config({
			-- update_in_insert = true,
			underline = false,
			signs = {
				severity = { min = vim.diagnostic.severity.WARN },
			},
			-- virtual_text = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})
	end,
}
