-- return {
-- 	"nvim-telescope/telescope.nvim",
--
-- 	branch = "0.1.x",
--
-- 	dependencies = {
-- 		"nvim-lua/plenary.nvim",
-- 		"nvim-telescope/telescope-fzf-native.nvim",
-- 		-- "nvim-telescope/telescope-ui-select.nvim",
-- 		build = "make",
-- 	},
-- 	config = function()
-- 		require("telescope").setup({
--             --CAN MAKE THIS BLOCK UNCOMMENTED IF YOU WANT SOME FANCY OPTIONS------------> defaults = {
-- 			-- 	file_ignore_patterns = { "%.git/" }, -- Optional: ignore git files
-- 			-- 	preview = {
-- 			-- 		hide_on_startup = true,
-- 			-- 	},
-- 			-- 	mappings = {
-- 			-- 		i = {
-- 			-- 			["<C-p>"] = false, -- Disable preview in insert mode
-- 			-- 		},
-- 			-- 		n = {
-- 			-- 			["<C-p>"] = false, -- Disable preview in normal mode
-- 			-- 		},
-- 			-- 	},
-- 			-- },
-- 			--
-- 			-- -- This line disables the previewer
-- 			-- pickers = {
-- 			-- 	find_files = {
-- 			-- 		previewer = true, -- Disable preview for find_files
-- 			-- 	},
-- 			-- 	live_grep = {
-- 			-- 		previewer = true, -- Disable preview for live_grep
-- 			-- 	},
-- 			--              help_tags = {
-- 			--                  previewer = true,
-- 			--              }
-- 			-- },
--             -- FOR SOME FANCY THINGS UNCOMMENT ABOVE BLOCK ---------------------->
-- 			-- extenstions = {
-- 			--     ["ui-select"] = {
-- 			--         require("telescope.themes").get_dropdown {
-- 			--             -- even more opts
-- 			--         }
-- 			--     },
-- 			-- },
-- 		})
-- 		-- require("telescope").load_extension("ui-select")
--
-- 		local builtin = require("telescope.builtin")
-- 		vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
-- 		vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
-- 		vim.keymap.set("n", "<leader>fk", builtin.keymaps, {})
-- 		vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
-- 		-- vim.keymap.set("n", "<C-p>", builtin.git_files, {})
-- 		vim.keymap.set("n", "<C-g>", builtin.git_files, {})
-- 		vim.keymap.set("n", "<leader>fb", builtin.current_buffer_fuzzy_find, {})
-- 		-- vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
-- 		-- vim.keymap.set("n", "<leader>tr", builtin.lsp_references, {})
-- 		vim.keymap.set("n", "<leader>fw", function()
-- 			local word = vim.fn.expand("<cword>")
-- 			builtin.grep_string({ search = word })
-- 		end) -- The word under your cursor will be found throughout every file
-- 		vim.keymap.set("n", "<leader>fW", function()
-- 			local word = vim.fn.expand("<cWORD>")
-- 			builtin.grep_string({ search = word })
-- 		end)
-- 		vim.keymap.set("n", "<leader>ps", function()
-- 			builtin.grep_string({ search = vim.fn.input("Grep > ") })
-- 		end)
-- 	end,
-- }

return {
	"nvim-telescope/telescope.nvim",

	-- tag = "0.1.5",

	dependencies = {
		"nvim-lua/plenary.nvim",
	},

	config = function()
		require("telescope").setup({
			-- -- This line disables the previewer
			defaults = {
				preview = {
					hide_on_startup = true,
				},
			},
			-- pickers = {
			-- 	find_files = {
			-- 		previewer = false, -- Disable preview for find_files
			-- 	},
			-- 	live_grep = {
			-- 		previewer = true, -- Disable preview for live_grep
			-- 	},
			-- 	help_tags = {
			-- 		previewer = true,
			-- 	},
			-- },
		})

		-- local preview_utils = require("telescope.previewers.utils")
		-- preview_utils.ts_highlighter = function(bufnr, ft)
		-- 	local lang = vim.treesitter.language.get_lang(ft) or ft
		-- 	if not lang or lang == "" then
		-- 		return false
		-- 	end
		--
		-- 	return pcall(vim.treesitter.start, bufnr, lang)
		-- end

		local builtin = require("telescope.builtin")

		-- show all the symbols in the project(functions, variables etc)
		vim.keymap.set("n", "<leader>fws", function()
			require("telescope.builtin").lsp_workspace_symbols({
				query = vim.fn.expand("<cword>"),
			})
		end)
		-- show all the symbols in the current file only(functions, variables etc)
		vim.keymap.set("n", "<leader>fds", function()
			require("telescope.builtin").lsp_document_symbols({
				symbol_width = 50,
			})
		end)
		--similar to go to implementation (gi)
		vim.keymap.set("n", "<leader>fi", builtin.lsp_implementations, {})

		vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
		vim.keymap.set("n", "<leader>fk", builtin.keymaps, {})
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
		vim.keymap.set("n", "<C-g>", builtin.git_files, {})
		vim.keymap.set("n", "<leader>fb", builtin.current_buffer_fuzzy_find, {})
		-- vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
		-- vim.keymap.set("n", "<leader>tr", builtin.lsp_references, {})
		vim.keymap.set("n", "<leader>fw", function()
			local word = vim.fn.expand("<cword>")
			builtin.grep_string({ search = word })
		end) -- The word under your cursor will be found throughout every file
		vim.keymap.set("n", "<leader>fW", function()
			local word = vim.fn.expand("<cWORD>")
			builtin.grep_string({ search = word })
		end)
		vim.keymap.set("n", "<leader>ps", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)
	end,
}
