--
-- return {
--     "williamboman/mason.nvim",
--     dependencies = {
--         "williamboman/mason-lspconfig.nvim",
--         "WhoIsSethDaniel/mason-tool-installer.nvim",
--     },
--     config = function()
--         local mason = require("mason")
--         local mason_lspconfig = require("mason-lspconfig")
--         local mason_tool_installer = require("mason-tool-installer")
--
--         -- Setup mason UI and basic options
--         mason.setup({
--             ui = {
--                 icons = {
--                     package_installed = "✓",
--                     package_pending = "➜",
--                     package_uninstalled = "✗",
--                 },
--             },
--         })
--
--         -- Setup mason-lspconfig with new automatic enable feature
--         mason_lspconfig.setup({
--             ensure_installed = {
--                 "tsserver",    -- changed from "ts_ls" to "tsserver" (correct LSP name)
--                 "html",
--                 "cssls",
--                 "clangd",
--                 "lua_ls",
--                 "jdtls",
--                 "emmet_ls",
--             },
--             -- New option to automatically enable servers installed via mason
--             automatic_enable = true,
--         })
--
--         -- Setup mason-tool-installer to install external tools
--         mason_tool_installer.setup({
--             ensure_installed = {
--                 "prettier",   -- formatter
--                 "stylua",     -- lua formatter
--                 "pyright",    -- python LSP
--                 "eslint_d",   -- eslint daemon
--             },
--             auto_update = true,   -- optionally auto update installed tools
--             run_on_start = true,  -- run installer on startup
--         })
--     end,
-- }



return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        -- import mason
        local mason = require("mason")
        -- import mason-lspconfig
        local mason_lspconfig = require("mason-lspconfig")
        local mason_tool_installer = require("mason-tool-installer")
        -- enable mason and configure icons
        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        mason_lspconfig.setup({
            -- list of servers for mason to install
            ensure_installed = {
                "ts_ls",
                "html",
                "cssls",
                "gopls",
                -- "clangd",
                -- "tailwindcss",
                -- "svelte",
                "lua_ls",
                -- "ruff",
                -- "jdtls",
                -- "pylsp",
                -- "graphql",
                -- "emmet_ls",
                -- "prismals",
            },
        })

        mason_tool_installer.setup({
            ensure_installed = {
                -- "prettier", -- prettier formatter
                "stylua",   -- lua formatter
                -- "isort",    -- python formatter
                "pyright",
                -- "black",    -- python formatter
                -- "eslint_d",
            },
        })
    end,
}
