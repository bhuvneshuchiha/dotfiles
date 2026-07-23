function ColorMyPencils(color)
	color = color or "rose-pine-moon"
	-- color = color or "rose-pine-main"
	-- color = color or "vague"
	-- color = color or "ash"
	-- color = color or "oldworld"
	-- color = color or "gruber-darker"
	-- color = color or "sonokai"
	-- color = color or "onedark"
	-- color = color or "tokyonight-storm"
	-- color = color or "moonfly" -- good
	-- color = color or "catppuccin-mocha"
	-- color = color or "kanagawa"
	-- color = color or "gruvbuddy"
	-- color = color or "ayu-mirage"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "netrwDir", { bold = true })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })

	-- To make the folder icons bold in tokyonight
	local hl = vim.api.nvim_get_hl(0, { name = "Directory", link = false })
	hl.bold = true
	vim.api.nvim_set_hl(0, "netrwDir", hl)


	-- StatusLine = {
	-- 	fg = "#908caa", -- subtle
	-- 	bg = "#2a273f", -- surface
	-- },

	-- vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "none" })
	-- This is to have tokyonight bg in rose pine
	-- local bg = "#1a1b26" -- tokyonight-night bg

	-- if color == "rose-pine-moon" then
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })
	-- vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#000000", fg = "#7a7a7a" })
	-- vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "#000000" })
	-- vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "#000000", fg = "#7a7a7a" })
	-- vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "#000000" })
	-- vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = "#000000", fg = "#7a7a7a" })
	-- vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "#000000" })
	-- vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { bg = "#000000", fg = "#7a7a7a" })
	-- vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "#000000" })
	-- vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { bg = "#000000", fg = "#7a7a7a" })
	-- end
end

return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		enabled = true,
		priority = 1000,
		config = function()
			local tokyo = require("tokyonight")
			tokyo.setup({
				transparent = true,
				on_colors = function(colors)
					-- colors.fg = "#FFFFFF" -- Set pure white for foreground
					-- colors.fg = "#e0def4" -- Set pure white for foreground
					colors.error = "#eb6f92"
					colors.warning = "#f6c177"
				end,
				styles = {
					sidebars = "transparent",
					-- floats = "transparent",
					comments = { italic = false },
					keywords = { italic = false },
				},
				-- on_highlights = function(hl, c)
				-- 	hl["@lsp.code.unused"] = { fg = c.comment, italic = true }
				-- end,
			})
			-- vim.cmd.colorscheme("tokyonight")
			-- vim.cmd.colorscheme("tokyonight-night")
			-- vim.cmd.colorscheme("tokyonight-storm")
			-- vim.cmd.colorscheme("tokyonight-moon")
			-- vim.cmd.colorscheme("tokyonight-day")

			-- Transparent background fix
			vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
			vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
		end,
	},

	{
		"Shatur/neovim-ayu",
		config = function()
			require("ayu").setup({
				transparent = true,
			})
		end,
	},
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	lazy = false,
	-- 	opts = {},
	-- 	config = function()
	-- 		require("tokyonight").setup({
	-- 			on_colors = function(colors)
	-- 				-- colors.fg = "#FFFFFF" -- Set pure white for foreground
	-- 				-- colors.fg = "#e0def4" -- Set pure white for foreground
	-- 				colors.error = "#eb6f92"
	-- 				-- colors.warning = "#f6c177"
	-- 			end,
	-- 			on_highlights = function(hl, colors)
	-- 				hl.ErrorMsg = { fg = colors.red, bold = true }
	-- 			end,
	--
	-- 			styles = {
	-- 				comments = { italic = false },
	-- 				keywords = { italic = false },
	-- 			},
	-- 			transparent = true,
	-- 		})
	-- 		ColorMyPencils()
	-- 	end,
	-- },

	{ "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },

	{
		"vague2k/vague.nvim",
		config = function()
			require("vague").setup({
				transparent = true,
				italic = false,
				colors = {},
			})
		end,
	},

	-- {
	-- "drewxs/ash.nvim",
	-- lazy = false,
	-- priority = 1000,
	-- config = function ()
	--     require("ash").setup ({
	--         compile_path = vim.fn.stdpath("cache") .. "/ash",
	--
	--         transparent = false, -- transparent background
	--         term_colors = true, -- terminal colors (e.g. g:terminal_color_x)
	--         no_italic = true, -- disable italics
	--         no_bold = true, -- disable bold
	--         no_underline = true, -- disable underlines
	--
	--         -- override highlight groups [function/table]
	--         -- e.g. highlights = function(colors)
	--         --     return {
	--         --         Comment = { fg = colors.red },
	--         --         CmpBorder = { fg = colors.none },
	--         --     }
	--         -- end
	--         highlights = {
	--             StatusLine = { fg = "#6e6a86", bg = "#232136" },
	--         },
	--
	--         -- override style groups
	--         -- e.g. comments = { "italic", "bold" }
	--         styles = {
	--             comments = {},
	--             conditionals = {},
	--             loops = {},
	--             functions = {},
	--             keywords = {},
	--             strings = {},
	--             variables = {},
	--             numbers = {},
	--             booleans = {},
	--             properties = {},
	--             types = {},
	--             operators = {},
	--         },
	--     })
	-- end,
	-- },

	-- {
	-- "dgox16/oldworld.nvim",
	-- lazy = false,
	-- priority = 1000,
	-- config = function()
	--     require("oldworld").setup({
	--         transparent = true,
	--         styles = {
	--             comments = { italic = false },
	--             conditionals = { italic = false},
	--             loops = { italic = false},
	--             functions = { italic = false },
	--             keywords = { italic = false, bold = true},
	--             strings = { italic = false },
	--             variables = { italic = false } ,
	--             numbers = { italic = false },
	--             booleans = { italic = false, bold = true},
	--             properties = { italic = false },
	--             types = { italic = false, bold = true},
	--             operators = { italic = false },
	--         },
	--         integrations = {
	--         --     hop = true,
	--             telescope = true,
	--             treesitter = true,
	--             lsp = true,
	--             cmp = true,
	--         --     gitsigns = true,
	--         --     which_key = true,
	--         --     indent_blankline = true
	--         },
	--         -- highlight_overrides = {
	--         --     Comment = { bg = "#ff0000", italic = false, underline = false },
	--         -- }
	--     })
	--
	--
	--     -- vim.cmd("colorscheme oldworld")
	-- end,
	-- },

	{
		"blazkowolf/gruber-darker.nvim",
		lazy = false,
		opts = {
			bold = false,
			invert = {
				signs = false,
				tabline = false,
				visual = false,
			},
			italic = {
				strings = false,
				comments = false,
				operators = false,
				folds = false,
			},
			undercurl = false,
			underline = false,
		},
		config = function(_, opts)
			require("gruber-darker").setup(opts)
		end,
	},
	--
	-- {
	-- 	"navarasu/onedark.nvim",
	-- 	priority = 1000, -- make sure to load this before all the other start plugins
	-- 	config = function()
	-- 		require("onedark").setup({
	-- 			style = "darker",
	-- 		})
	-- 		-- Enable theme
	-- 		require("onedark").load()
	-- 	end,
	-- },

	-- {
	-- -- 	-- -- Disabled term gui colors in init.lua
	-- 	"sainnhe/sonokai",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.g.sonokai_enable_italic = "0"
	-- 		vim.g.sonokai_disable_italic_comment = 1
	-- 		vim.g.sonokai_style = "andromeda" -- or 'default', 'atlantis', 'shusia', 'maia', 'espresso'
	--            transparent = 1,
	-- 	end,
	-- },
	--
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	config = function()
	-- 		require("tokyonight").setup({
	-- 			on_colors = function(colors)
	-- 				-- colors.fg = "#FFFFFF" -- Set pure white for foreground
	-- 				-- colors.fg = "#e0def4" -- Set pure white for foreground
	-- 				colors.error = "#eb6f92"
	-- 				-- colors.warning = "#f6c177"
	-- 			end,
	-- 			on_highlights = function(hl, colors)
	-- 				hl.ErrorMsg = { fg = colors.red, bold = true }
	-- 			end,
	--
	-- 			-- your configuration comes here
	-- 			-- or leave it empty to use the default settings
	-- 			style = "storm",
	-- 			transparent = false, -- Enable this to disable setting the background color
	-- 			terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
	-- 			styles = {
	-- 				-- Style to be applied to different syntax groups
	-- 				-- Value is any valid attr-list value for `:help nvim_set_hl`
	-- 				comments = { italic = false },
	-- 				keywords = { italic = false },
	-- 				-- Background styles. Can be "dark", "transparent" or "normal"
	-- 				sidebars = "dark", -- style for sidebars, see below
	-- 				floats = "dark", -- style for floating windows
	-- 			},
	-- 		})
	-- 	end,
	-- },
	--
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				disable_background = true,
				styles = {
					italic = false,
					-- transparency = true
				},
				highlight_groups = {
					-- String = { fg = "#E5C07B" },    -- yellowish string color from Vague
					-- String = { fg = "#e5c39d" },    -- yellowish string color from Vague
					-- String = { fg = "#e8b589" },
					String = { fg = "#f5d2a6" },
					-- ["@field"] = { fg = "#B4D4CF" }, -- keyscolor
					-- ["@property"] = { fg = "#B4D4CF" }, -- additional keys/properties
					-- ["@tag"] = { fg = "#B4D4CF" }, -- tags
					-- ["@type"] = { fg = "#B4D4CF" }, -- types
					-- ["@tag.attribute"] = { fg = "#B4D4CF" }, -- tag attributes if you want

					--- Here
					-- ["@parameter"] = { fg = "#bb9dbd" },
					-- ["@constant"] = { fg = "#aeaed1" },
					["@function"] = { fg = "#c48282" },
					["@keyword"] = { fg = "#6e94b2" },
					["@keyword.conditional"] = { fg = "#6e94b2" },
					["@keyword.return"] = { fg = "#6e94b2" },
					["@keyword.import"] = { fg = "#6e94b2" },
					["@keyword.repeat"] = { fg = "#6e94b2" },
					---Here
					-- ["@operator"] = { fg = "#90a0b5" },
					-- ["@string"] = { fg = "#e8b589" },
					-- ["@number"] = { fg = "#e0a363" },
					-- ["@number"] = { fg = "#f5d2a6" },
					StatusLine = { fg = "subtle", bg = "surface" },
				},
			})

			ColorMyPencils()
		end,
	},

	-- {
	-- 	"rose-pine/neovim",
	-- 	name = "rose-pine",
	-- 	config = function()
	-- 		require("rose-pine").setup({
	-- 			variant = "moon", -- explicitly set Rose Pine Moon
	-- 			disable_background = true,
	-- 			-- disable_float_background = true,
	-- 			-- disable_italics = true, -- global italic disable
	-- 			styles = {
	-- 				italic = false,
	-- 			},
	-- 			highlight_groups = {
	-- 				-- General
	-- 				Normal = { fg = "#cdcdcd", bg = "none" },
	-- 				Comment = { fg = "#606079" },
	-- 				Constant = { fg = "#aeaed1" },
	-- 				String = { fg = "#e8b589" },
	-- 				Number = { fg = "#e0a363" },
	-- 				Boolean = { fg = "#e0a363" },
	-- 				Float = { fg = "#e0a363" },
	-- 				Identifier = { fg = "#cdcdcd" },
	-- 				Function = { fg = "#c48282" },
	-- 				Statement = { fg = "#6e94b2" }, -- keywords
	-- 				Operator = { fg = "#90a0b5" },
	-- 				Type = { fg = "#9bb4bc" },
	-- 				Error = { fg = "#d8647e" },
	-- 				WarningMsg = { fg = "#f3be7c" },
	-- 				-- DiagnosticHint = { fg = "#7e98e8" },
	-- 				Visual = { bg = "#333738" },
	--
	-- 				-- UI
	-- 				-- LineNr = { fg = "#878787" },
	-- 				-- CursorLineNr = { fg = "#cdcdcd", bg = "#252530" },
	-- 				-- VertSplit = { fg = "#252530" },
	-- 				-- StatusLine = { fg = "#cdcdcd", bg = "#2a273f" },
	-- 				-- StatusLineNC = { fg = "#606079", bg = "#141415" },
	-- 				-- WinSeparator = { fg = "#252530" },
	--
	-- 				-- -- Completion Menu
	-- 				-- Pmenu = { fg = "#cdcdcd", bg = "#232136" },
	-- 				-- PmenuSel = { fg = "#cdcdcd", bg = "#44415a" },
	-- 				-- PmenuThumb = { bg = "#56526e" },
	-- 				-- PmenuSbar = { bg = "#2a273f" },
	--
	-- 				-- LSP
	-- 				-- DiagnosticError = { fg = "#d8647e" },
	-- 				-- DiagnosticWarn = { fg = "#f3be7c" },
	-- 				-- DiagnosticInfo = { fg = "#cdcdcd" },
	-- 				-- DiagnosticHint = { fg = "#7e98e8" },
	--
	-- 				-- Treesitter & semantic groups
	-- 				["@field"] = { fg = "#b4d4cf" },
	-- 				["@property"] = { fg = "#b4d4cf" },
	-- 				["@tag"] = { fg = "#b4d4cf" },
	-- 				["@type"] = { fg = "#b4d4cf" },
	-- 				["@tag.attribute"] = { fg = "#b4d4cf" },
	-- 				["@parameter"] = { fg = "#bb9dbd" },
	-- 				["@constant"] = { fg = "#aeaed1" },
	-- 				["@function"] = { fg = "#c48282" },
	-- 				["@keyword"] = { fg = "#6e94b2" },
	-- 				["@operator"] = { fg = "#90a0b5" },
	-- 				["@string"] = { fg = "#e8b589" },
	-- 				["@number"] = { fg = "#e0a363" },
	-- 			},
	-- 		})
	-- 		ColorMyPencils()
	-- 	end,
	-- },

	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			local colors = require("catppuccin.palettes").get_palette("mocha")
			require("catppuccin").setup({
				no_italic = true,
				flavour = "mocha",
				styles = {
					comments = {},
					italic = false,
					conditionals = {},
					loops = {},
					functions = {},
					keywords = { "bold" },
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
					operators = {},
				},
				custom_highlights = {
					-- StatusLine = { bg = colors.base, fg = colors.base },
					StatusLine = {
						fg = "#908caa", -- subtle
						bg = "#2a273f", -- surface
					},

					-- StatusLineNC = { bg = colors.base, fg = colors.base },
				},
				integrations = {
					treesitter = true,
					cmp = true,
					mason = true,
					dadbod_ui = true,
					gitsigns = {
						enabled = true,
						transparent = false,
					},
					telescope = {
						enabled = true,
					},
					native_lsp = {
						enabled = true,
						virtual_text = {
							errors = {},
							hints = {},
							warnings = {},
							information = {},
							ok = {},
							italic = {},
						},
						underlines = {
							errors = {},
							hints = {},
							warnings = {},
							information = {},
							ok = {},
						},
						inlay_hints = {
							background = true,
						},
					},
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
