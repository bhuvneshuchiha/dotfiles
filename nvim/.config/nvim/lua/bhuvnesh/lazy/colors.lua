function ColorMyPencils(color)
    -- color = color or "rose-pine-moon"
    -- color = color or "ash"
    -- color = color or "oldworld"
    -- color = color or "gruber-darker"
    -- color = color or "sonokai"
    -- color = color or "onedark"
    color = color or "tokyonight"
    -- color = color or "kanagawa"
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
        end
    },

    {
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
    },

    {
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
    },

    {
        -- "blazkowolf/gruber-darker.nvim",
        -- lazy = false,
        -- opts = {
        --     bold = true,
        --     invert = {
        --         signs = false,
        --         tabline = false,
        --         visual = false,
        --     },
        --     italic = {
        --         strings = false,
        --         comments = false,
        --         operators = false,
        --         folds = false,
        --     },
        --     undercurl = false,
        --     underline = false,
        -- },
        -- config = function(_, opts)
        --     require("gruber-darker").setup(opts)
        -- end,
    },


    {
        -- "navarasu/onedark.nvim",
        -- priority = 1000, -- make sure to load this before all the other start plugins
        -- config = function()
        --     require('onedark').setup {
        --         style = 'darker'
        --     }
        --     -- Enable theme
        --     require('onedark').load()
        -- end
    },

    {
        -- -- Disabled term gui colors in init.lua
        -- "sainnhe/sonokai",
        -- lazy = false,
        -- priority = 1000,
        -- config = function()
        --     vim.g.sonokai_enable_italic = "0"
        --     vim.g.sonokai_disable_italic_comment = 1
        --     vim.g.sonokai_style = 'andromeda' -- or 'default', 'atlantis', 'shusia', 'maia', 'espresso'
        -- end,
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
                transparent = true,     -- Enable this to disable setting the background color
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
                    -- transparency = true
                },
                highlight_groups = {
                    -- String = { fg = "#E5C07B" },    -- yellowish string color from Vague
                    -- String = { fg = "#e5c39d" },    -- yellowish string color from Vague
                    String = { fg = "#d6bd8b" },             -- yellowish string color from Vague
                    ["@field"] = { fg = "#B4D4CF" },         -- keys
                    ["@property"] = { fg = "#B4D4CF" },      -- additional keys/properties
                    ["@tag"] = { fg = "#B4D4CF" },           -- tags
                    ["@type"] = { fg = "#B4D4CF" },          -- types
                    ["@tag.attribute"] = { fg = "#B4D4CF" }, -- tag attributes if you want
                    -- StatusLine = { fg = "subtle", bg = "surface" },

                },
            })

            ColorMyPencils();
        end
    },

}
