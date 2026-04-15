-- return {
--     "nvim-treesitter/nvim-treesitter",
--     event = { "BufReadPre", "BufNewFile" },
--     build = ":TSUpdate",
--     branch = "master",
--     dependencies = {
--         "windwp/nvim-ts-autotag",
-- 		"nvim-treesitter/nvim-treesitter-textobjects",
--     },
--     config = function()
--         -- import nvim-treesitter plugin
--         local treesitter = require("nvim-treesitter.configs")
--
--         -- configure treesitter
--         treesitter.setup({ -- enable syntax highlighting
--             highlight = {
--                 enable = true,
--             --      disable = function(lang, buf)
--             --         -- if lang == "html" then
--             --         --     print("disabled")
--             --         --     return true
--             --         -- end
--             --
--             --         local max_filesize = 20000 * 1024 -- 20MB
--             --         local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
--             --         if ok and stats and stats.size > max_filesize then
--             --             vim.notify(
--             --                 "File larger than 20MB treesitter disabled for performance",
--             --                 vim.log.levels.WARN,
--             --                 {title = "Treesitter"}
--             --             )
--             --             return true
--             --         end
--             --     end,
--             },
--
--             -- enable indentation
--             indent = { enable = true },
--             -- enable autotagging (w/ nvim-ts-autotag plugin)
--             autotag = {
--                 enable = true,
--             },
-- 			textobjects = {
-- 				select = {
-- 					enable = true,
-- 					lookahead = true,
-- 					keymaps = {
-- 						["af"] = "@function.outer",
-- 						["if"] = "@function.inner",
-- 					},
-- 				},
-- 			},
--             -- ensure these language parsers are installed
--             ensure_installed = {
--                 "cpp",
--                 "json",
--                 "go",
--                 "c",
--                 "rust",
--                 "zig",
--                 "javascript",
--                 "typescript",
--                 "vue",
--                 "tsx",
--                 "rust",
--                 "yaml",
--                 "html",
--                 "java",
--                 "css",
--                 "python",
--                 "prisma",
--                 "markdown",
--                 "markdown_inline",
--                 "svelte",
--                 "graphql",
--                 "bash",
--                 "lua",
--                 "vim",
--                 "dockerfile",
--                 "gitignore",
--                 "query",
--                 "vimdoc",
--                 "c",
--                 "rust",
--                 "zig",
--             },
--             incremental_selection = {
--                 enable = true,
--                 keymaps = {
--                     init_selection = "<C-space>",
--                     node_incremental = "<C-space>",
--                     scope_incremental = false,
--                     node_decremental = "<bs>",
--                 },
--             },
--         })
--     end,
-- }

return {
	"nvim-treesitter/nvim-treesitter",
	-- event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	branch = "master", -- very important and do not use lazy = false
	lazy = false,

	dependencies = {
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			branch = "master",
			lazy = false,
		},
	},
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		treesitter.setup({
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
					},
				},
			},
			ensure_installed = {
				"cpp",
				"json",
				"go",
				"c",
				"rust",
				"zig",
				"javascript",
				"typescript",
				"tsx",
				"yaml",
				"html",
				"java",
				"css",
				"python",
				"markdown",
				"graphql",
				"bash",
				"lua",
				"vim",
				"dockerfile",
				"gitignore",
				"query",
				"vimdoc",
			},
			sync_install = false,
			auto_install = true,
		})
	end,
}

-- return {
-- 	{
-- 		"nvim-treesitter/nvim-treesitter",
-- 		build = ":TSUpdate",
-- 		lazy = false,
-- 		init = function()
-- 			local parsers = {
-- 				"cpp",
-- 				"json",
-- 				"go",
-- 				"c",
-- 				"rust",
-- 				"zig",
-- 				"javascript",
-- 				"typescript",
-- 				"tsx",
-- 				"yaml",
-- 				"html",
-- 				"java",
-- 				"css",
-- 				"python",
-- 				"markdown",
-- 				"graphql",
-- 				"bash",
-- 				"lua",
-- 				"vim",
-- 				"dockerfile",
-- 				"gitignore",
-- 				"query",
-- 				"vimdoc",
-- 			}
--
-- 			local group = vim.api.nvim_create_augroup("ThePrimeagenTreesitter", { clear = true })
-- 			vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
-- 				group = group,
-- 				callback = function()
-- 					if vim.bo.buftype ~= "" then
-- 						return
-- 					end
--
-- 					pcall(vim.treesitter.start, 0)
-- 				end,
-- 			})
--
-- 			vim.api.nvim_create_autocmd("User", {
-- 				group = group,
-- 				pattern = "VeryLazy",
-- 				once = true,
-- 				callback = function()
-- 					require("nvim-treesitter").install(parsers)
-- 				end,
-- 			})
-- 		end,
-- 	},
-- 	{
-- 		"nvim-treesitter/nvim-treesitter-textobjects",
-- 		lazy = false,
-- 		config = function()
-- 			require("nvim-treesitter-textobjects").setup({
-- 				select = {
-- 					enable = true,
-- 					lookahead = true,
-- 					keymaps = {
-- 						["af"] = "@function.outer",
-- 						["if"] = "@function.inner",
-- 					},
-- 				},
-- 			})
-- 		end,
-- 	},
-- }
