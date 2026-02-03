-- -- lua/plugins/oil.lua
-- return {
--   "stevearc/oil.nvim",
--   dependencies = { "nvim-tree/nvim-web-devicons" },
--   lazy = false,
--   keys = {
--     { "-", "<CMD>Oil<CR>", desc = "Open parent directory in Oil" },
--   },
--   opts = function()
--     -- Create a cached table for git-ignored files
--     local git_ignored = setmetatable({}, {
--       __index = function(self, key)
--         local proc = vim.system(
--           { "git", "ls-files", "--ignored", "--exclude-standard", "--others", "--directory" },
--           {
--             cwd = key,
--             text = true,
--           }
--         )
--         local result = proc:wait()
--         local ret = {}
--         if result.code == 0 then
--           for line in vim.gsplit(result.stdout, "\n", { plain = true, trimempty = true }) do
--             -- Remove trailing slash
--             line = line:gsub("/$", "")
--             table.insert(ret, line)
--           end
--         end
--
--         rawset(self, key, ret)
--         return ret
--       end,
--     })
--
--     -- Create a module-scoped variable for detail view toggle
--     local detail_view_enabled = false
--
--     return {
--       -- File system options
--       columns = {
--         "icon",
--       },
--       -- Buffer display and behavior
--       view_options = {
--         -- Show hidden files (respects .gitignore)
--         show_hidden = true,
--         is_hidden_file = function(name, _)
--           -- dotfiles are always considered hidden
--           if vim.startswith(name, ".") then
--             return true
--           end
--           local dir = require("oil").get_current_dir()
--           -- if no local directory (e.g. for ssh connections), always show
--           if not dir then
--             return false
--           end
--           -- Check if file is gitignored
--           return vim.list_contains(git_ignored[dir], name)
--         end,
--         -- Natural sort order (10.txt comes after 2.txt)
--         sort = {
--           { "type", "asc" },
--           { "name", "asc" },
--         },
--       },
--       -- UI settings
--       win_options = {
--         wrap = false,
--         signcolumn = "no",
--         cursorcolumn = false,
--         foldcolumn = "0",
--         spell = false,
--         list = false,
--         conceallevel = 3,
--         concealcursor = "nvic",
--       },
--       keymaps = {
--         ["gd"] = {
--           desc = "Toggle file detail view",
--           callback = function()
--             detail_view_enabled = not detail_view_enabled
--             if detail_view_enabled then
--               require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
--             else
--               require("oil").set_columns({ "icon" })
--             end
--           end,
--         },
--       },
--       -- Status line integration
--       use_default_keymaps = true,
--       delete_to_trash = true,
--       skip_confirm_for_simple_edits = true,
--       prompt_save_on_select_new_entry = true,
--       cleanup_delay_ms = 2000,
--       lsp_file_methods = {
--         autosave_changes = true,
--       },
--     }
--   end,
--   -- Additional setup hook for post-initialization
--   config = function(_, opts)
--     require("oil").setup(opts)
--     vim.api.nvim_create_autocmd("FileType", {
--       pattern = "oil",
--       callback = function()
--         vim.opt_local.scrolloff = 3
--       end,
--     })
--   end,
-- }




-- LATEST ONE IS BELOW --


return {
    "stevearc/oil.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        require("oil").setup({
            -- columns = { "icons" },
            default_file_explorer = false, -- If you want to use this with netrw else set true
            columns = { { 'icon' } },
            keymaps = {
                ["<C-h>"] = false,
                ["<M-h>"] = "actions.select_split",
            },
            delete_to_trash = true,
            view_options = {
                show_hidden = true,
            },
            skip_confirm_for_simple_edits = true,
        })
        -- opens parent dir over current active window
        vim.keymap.set("n", "<leader>-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

        -- open parent dir in float window
        -- vim.keymap.set("n", "<leader>-", require("oil").toggle_float)

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "oil", -- Adjust if Oil uses a specific file type identifier
            callback = function()
                vim.opt_local.cursorline = true
            end,
        })
    end,

}
