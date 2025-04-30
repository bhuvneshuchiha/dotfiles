return {
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*", -- Follow the latest release
        build = "make install_jsregexp", -- Install jsregexp (optional)

        dependencies = { "rafamadriz/friendly-snippets" },

        config = function()
            local ls = require("luasnip")

            -- Extend snippets for different file types
            ls.filetype_extend("javascript", { "jsdoc" })
            ls.filetype_extend("typescript", { "javascript" })
            ls.filetype_extend("typescriptreact", { "typescript", "javascript" })
            ls.filetype_extend("lua", { "luasnip" })
            ls.filetype_extend("go", { "golang" })
            ls.filetype_extend("cpp", { "c" })
            ls.filetype_extend("python", { "py" })
            ls.filetype_extend("java", { "javadoc" })
            ls.filetype_extend("html", { "html5" })

            -- Define key mappings for snippet expansion and navigation
            vim.keymap.set({"i"}, "<C-s>e", function()
                if ls.expand_or_jumpable() then
                    ls.expand_or_jump()
                end
            end, { silent = true })

            vim.keymap.set({"i", "s"}, "<C-s>;", function()
                if ls.jumpable(1) then
                    ls.jump(1)
                end
            end, { silent = true })

            vim.keymap.set({"i", "s"}, "<C-s>,", function()
                if ls.jumpable(-1) then
                    ls.jump(-1)
                end
            end, { silent = true })

            vim.keymap.set({"i", "s"}, "<C-E>", function()
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end, { silent = true })
        end,
    }
}

