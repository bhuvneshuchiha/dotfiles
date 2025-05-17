return {
    "nvim-telescope/telescope.nvim",

    branch = "0.1.x",

    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-fzf-native.nvim",
        -- "nvim-telescope/telescope-ui-select.nvim",
        build = "make",
    },
    config = function()
        require("telescope").setup({
            defaults = {
                file_ignore_patterns = { "%.git/" }, -- Optional: ignore git files
                preview = {
                    hide_on_startup = true,
                },
                mappings = {
                    i = {
                        ["<C-p>"] = false, -- Disable preview in insert mode
                    },
                    n = {
                        ["<C-p>"] = false, -- Disable preview in normal mode
                    },
                },
            },

            -- This line disables the previewer
            pickers = {
                find_files = {
                    previewer = true, -- Disable preview for find_files
                },
                live_grep = {
                    previewer = true, -- Disable preview for live_grep
                },
            },
            -- extenstions = {
            --     ["ui-select"] = {
            --         require("telescope.themes").get_dropdown {
            --             -- even more opts
            --         }
            --     },
            -- },
        })
        -- require("telescope").load_extension("ui-select")


        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader><leader>", builtin.find_files, {})
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
        vim.keymap.set("n", "<leader>fk", builtin.keymaps, {})
        vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
        vim.keymap.set("n", "<C-g>", builtin.git_files, {})
        vim.keymap.set("n", "<leader>fB", builtin.current_buffer_fuzzy_find, {})
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
