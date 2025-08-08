function ColorMyPencils(color)
	color = color or "rose-pine-moon"
	-- color = color or "rose-pine"
	-- color = color or "tokyonight"
	-- color = color or "gruvbox"
	-- color = color or "gruvbuddy"
	vim.cmd.colorscheme(color)
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
end

return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		opts = {},
		config = function()
			ColorMyPencils()
		end,
	},

	{
		"ellisonleao/gruvbox.nvim",
		name = "gruvbox",
		config = function()
			require("gruvbox").setup({
				terminal_colors = true, -- add neovim terminal colors
				undercurl = false,
				underline = false,
				bold = true,
				italic = {
					strings = false,
					emphasis = false,
					comments = false,
					operators = false,
					folds = false,
				},
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				invert_intend_guides = false,
				inverse = true, -- invert background for search, diffs, statuslines and errors
				contrast = "", -- can be "hard", "soft" or empty string
				palette_overrides = {},
				overrides = {},
				dim_inactive = false,
				transparent_mode = true,
			})
		end,
	},

	{
		"folke/tokyonight.nvim",
		config = function()
			require("tokyonight").setup({
				on_colors = function(colors)
					-- colors.fg = "#FFFFFF" -- Set pure white for foreground
					-- colors.fg = "#e0def4" -- Set pure white for foreground
					colors.error = "#eb6f92"
					-- colors.warning = "#f6c177"
				end,
				on_highlights = function(hl, colors)
					hl.ErrorMsg = { fg = colors.red, bold = true }
				end,

				style = "night",
				transparent = true,
				terminal_colors = true,
				styles = {
					comments = { italic = false },
					keywords = { italic = false },
					-- Background styles. Can be "dark", "transparent" or "normal"
					sidebars = "dark",
					floats = "dark",
				},
			})
		end,
	},

	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				disable_background = true,
				styles = {
					italic = false,
				},
				highlight_groups = {
					-- String = { fg = "#d6bd8b" },    -- yellowish string color from Vague
					-- String = { fg = "#f5cb96" }, -- yellowish string color from Vague
					String = { fg = "#e8b589" }, -- yellowish string color from Vague
					["@field"] = { fg = "#B4D4CF" }, -- keys
					["@property"] = { fg = "#B4D4CF" }, -- additional keys/properties
					["@tag"] = { fg = "#B4D4CF" }, -- tags
					-- ["@type"] = { fg = "#B4D4CF" }, -- types
					["@tag.attribute"] = { fg = "#B4D4CF" }, -- tag attributes if you want

					-- Your added colors
					-- Keyword = { fg = "#6e94b2" }, -- keyword (e.g., if, return)
					-- ["@keyword"] = { fg = "#6e94b2" }, -- Tree-sitter keyword group
					-- ["@keyword.function"] = { fg = "#6e94b2" },
					-- ["@keyword.return"] = { fg = "#6e94b2" },

					["@keyword"] = { fg = "#6e94b2" }, -- all keywords fallback
					["@keyword.function"] = { fg = "#6e94b2" }, -- function
					["@keyword.return"] = { fg = "#6e94b2" }, -- return
					["@keyword.conditional"] = { fg = "#6e94b2" }, -- if, then, else

					Type = { fg = "#9bb4bc" }, -- type (e.g., int, string)
					["@type"] = { fg = "#9bb4bc" }, -- Tree-sitter type group
					Builtin = { fg = "#b4d4cf" },
				},
			})

			ColorMyPencils()
		end,
	},
}
