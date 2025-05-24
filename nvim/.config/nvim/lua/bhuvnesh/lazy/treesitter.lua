return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
        "windwp/nvim-ts-autotag",
    },
    config = function()
        -- import nvim-treesitter plugin
        local treesitter = require("nvim-treesitter.configs")

        -- configure treesitter
        treesitter.setup({ -- enable syntax highlighting
            highlight = {
                enable = true,
                 disable = function(lang, buf)
                    if lang == "html" then
                        print("disabled")
                        return true
                    end

                    local max_filesize = 10000 * 1024 -- 10MB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        vim.notify(
                            "File larger than 10MB treesitter disabled for performance",
                            vim.log.levels.WARN,
                            {title = "Treesitter"}
                        )
                        return true
                    end
                end,
            },

            -- enable indentation
            indent = { enable = true},
            -- enable autotagging (w/ nvim-ts-autotag plugin)
            autotag = {
                enable = true,
            },
            -- ensure these language parsers are installed
            ensure_installed = {
                "cpp",
                "json",
                "yaml",
                "toml",
                "go",
                "c",
                "rust",
                "zig",
                "javascript",
                "typescript",
                "tsx",
                "rust",
                "yaml",
                "html",
                "java",
                "css",
                "python",
                "prisma",
                "markdown",
                "markdown_inline",
                "svelte",
                "graphql",
                "bash",
                "lua",
                "vim",
                "php",
                "dockerfile",
                "gitignore",
                "query",
                "vimdoc",
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
        })
    end,
}
