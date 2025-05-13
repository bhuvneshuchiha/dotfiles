function ColorMyPencils(color)
    -- color = color or "rose-pine-moon"
    -- color = color or "rose-pine"
    color = color or "tokyonight"
    -- color = color or "gruvbox"
    -- color = color or "gruvbuddy"
    vim.cmd.colorscheme(color)
    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
end

return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        opts = {},
        config = function()
            ColorMyPencils()
        end
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

                -- your configuration comes here
                -- or leave it empty to use the default settings
                style = "storm",
                transparent = true,    -- Enable this to disable setting the background color
                terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
                styles = {
                    -- Style to be applied to different syntax groups
                    -- Value is any valid attr-list value for `:help nvim_set_hl`
                    comments = { italic = false },
                    keywords = { italic = false },
                    -- Background styles. Can be "dark", "transparent" or "normal"
                    sidebars = "dark", -- style for sidebars, see below
                    floats = "dark",   -- style for floating windows
                },
            })
        end
    },

    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require('rose-pine').setup({
                disable_background = true,
                styles = {
                    italic = false,
                },
                highlight_groups = {
                    -- String = { fg = "#E5C07B" },    -- yellowish string color from Vague
                    -- String = { fg = "#e5c39d" },    -- yellowish string color from Vague
                    String = { fg = "#d6bd8b" },    -- yellowish string color from Vague
                    ["@field"] = { fg = "#B4D4CF" }, -- keys
                    ["@property"] = { fg = "#B4D4CF" }, -- additional keys/properties
                    ["@tag"] = { fg = "#B4D4CF" }, -- tags
                    ["@type"] = { fg = "#B4D4CF" }, -- types
                    ["@tag.attribute"] = { fg = "#B4D4CF" }, -- tag attributes if you want

                },
            })

            ColorMyPencils();
        end
    },

}
