return {
    "neovim/nvim-lspconfig",
    dependencies = {
        -- "stevearc/conform.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        -- "saghen/blink.cmp", -- Use for blink.cmp
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*",
            build = "make install_jsregexp",
            dependencies = { "rafamadriz/friendly-snippets" },
        },
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        -- require("conform").setup({
        --     formatters_by_ft = {
        --         lua = { "stylua" },          -- For Lua files, use the "stylua" formatter
        --     go = { "gofmt" },            -- For Go files, use "gofmt"
        --     rust = { "rustfmt" },        -- For Rust files, use "rustfmt"
        --     python = { "black" },        -- For Python files, use "black"
        --     json = { "jq" },             -- For JSON files, use "jq"
        --     yaml = { "prettier" },
        --     javascript = {"prettier"},
        --     typescript= {"prettier"},
        --     }
        -- })
        local cmp = require("cmp")
        -- local cmp = require("blink.cmp") -- Use for blink.cmp
        local cmp_lsp = require("cmp_nvim_lsp")

        -- Comment out if you are using blink
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        -- local capabilities = require("blink.cmp").get_lsp_capabilities() -- Use for blink

        local keymap = vim.keymap -- for conciseness

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local opts = { buffer = ev.buf, silent = true }

                -- set keybinds
                opts.desc = "Show LSP references"
                keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

                opts.desc = "Go to declaration"
                keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

                opts.desc = "Show LSP definitions"
                keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

                opts.desc = "Show LSP implementations"
                keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

                opts.desc = "Show LSP type definitions"
                keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

                opts.desc = "See available code actions"
                keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

                opts.desc = "Smart rename"
                keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

                opts.desc = "Show buffer diagnostics"
                keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

                opts.desc = "Show line diagnostics"
                keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

                opts.desc = "Go to previous diagnostic"
                keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

                opts.desc = "Go to next diagnostic"
                keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

                opts.desc = "Show documentation for what is under cursor"
                keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

                opts.desc = "Restart LSP"
                keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
            end,
        })

        -- Use this to let nvim know which python to use, helps stop the lag
        -- during startup of a python file.
        vim.g.python3_host_prog = '/Users/bhuvnesh/virtualenvs/nvim-venv/bin/python3.13'

        -- For python venv setup using pyright
        -- local util = require("lspconfig/util")
        -- local path = util.path

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "gopls",
                "jdtls",
                -- "ruff",
                -- "pylsp",
                "clangd",
                "ts_ls", --tsserver name changed to ts_ls
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                    })
                end,

                ["gopls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.gopls.setup({
                        capabilities = capabilities,
                    })
                end,

                ["omnisharp"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.omnisharp.setup({
                        capabilities = capabilities,
                        cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
                        root_dir = lspconfig.util.root_pattern("*.sln", "*.csproj", ".git"),
                    })
                end,

                ["pyright"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.pyright.setup({
                        capabilities = capabilities,
                        before_init = function(_, config)
                            -- Use a default virtual environment path
                            local default_venv_path = vim.fn.expand("~/.virtualenvs/nvim-venv/bin/python3")

                            -- Use the Python interpreter from the current virtual environment if available
                            local venv_python = vim.fn.getenv("VIRTUAL_ENV")
                                and vim.fn.expand("$VIRTUAL_ENV/bin/python")
                                or default_venv_path

                            config.settings.python.pythonPath = venv_python
                        end,
                    })
                end,

                ["jdtls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.jdtls.setup({
                        capabilities = capabilities,
                    })
                end,

                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                                },
                            },
                        },
                    })
                end,
                ["ruff"] = function()
                	local lspconfig = require("lspconfig")
                	lspconfig.ruff.setup({
                		-- on_attach = function(client, bufnr)
                		--     -- Disable formatting for ruff
                		--     client.server_capabilities.documentFormattingProvider = true
                		--     client.server_capabilities.documentRangeFormattingProvider = true
                		-- end,
                		init_options = {
                			settings = {
                				-- configuration = "~/.config/ruff_settings/ruff.toml",

                				codeAction = {
                					fixViolation = {
                						enable = true,
                					},
                					disableRuleComment = {
                						enable = true,
                					},
                				},
                				lineLength = 88,
                				fixAll = false,
                				organizeImports = true,
                				showSyntaxErrors = true,
                				lint = {
                					enable = false,
                					extendIgnore = {},
                					ignore = {},
                					extendSelect = {},
                					select = {},
                				},
                				format = {
                					preview = false,
                				},
                			},
                		},
                	})
                end,

                -- Trying something new
                {
                    "nvim-lspconfig",
                    opts = {
                        inlay_hints = { enabled = true },
                    },
                },
                -- ["pylsp"] = function()
                --     -- configure pylsp server
                --     local lspconfig = require("lspconfig")
                --     lspconfig.pylsp.setup({
                --         capabilities = capabilities,
                --         settings = {
                --             pylsp = {
                --                 plugins = {
                --                     black = { enabled = true },
                --                     isort = { enabled = true },
                --                     -- jedi_completion = {
                --                     --     enabled = true,
                --                     --     eager = true,
                --                     --     include_params = true,
                --                     --     cache_for = { "numpy", "scipy" },
                --                     -- },
                --                     -- jedi_definition = {
                --                     --     enabled = true,
                --                     --     follow_imports = true,
                --                     --     follow_builtin_imports = true,
                --                     -- },
                --                     -- jedi_hover = { enabled = true },
                --                     -- jedi_references = { enabled = true },
                --                     -- jedi_signature_help = { enabled = true },
                --                     -- jedi_symbols = { enabled = true, all_scopes = true, include_import_symbols = true },
                --                     autopep8 = { enabled = false},
                --                     yapf = { enabled = false }, -- Disable formatting
                --                     pylint = { enabled = true},
                --                     -- pylint = {args = {'--ignore=E231', '-'}, enabled=true, debounce=200},
                --                     mccabe = { enabled = false },
                --                     pyflakes = { enabled = false},
                --                     pycodestyle = { enabled = false },
                --                     pyls_isort = { enabled = false },
                --                 },
                --
                --             },
                --         },
                --     })
                -- end,

                -- ["svelte"] = function()
                -- 	-- configure svelte server
                -- 	local lspconfig = require("lspconfig")
                -- 	lspconfig["svelte"].setup({
                -- 		capabilities = capabilities,
                -- 		on_attach = function(client, bufnr)
                -- 			vim.api.nvim_create_autocmd("BufWritePost", {
                -- 				pattern = { "*.js", "*.ts" },
                -- 				callback = function(ctx)
                -- 					-- Here use ctx.match instead of ctx.file
                -- 					client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
                -- 				end,
                -- 			})
                -- 		end,
                -- 	})
                -- end,
                --
                -- ["graphql"] = function()
                -- 	-- configure graphql language server
                -- 	local lspconfig = require("lspconfig")
                -- 	lspconfig["graphql"].setup({
                -- 		capabilities = capabilities,
                -- 		filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
                -- 	})
                -- end,

                ["emmet_ls"] = function()
                    -- configure emmet language server
                    local lspconfig = require("lspconfig")
                    lspconfig["emmet_ls"].setup({
                        capabilities = capabilities,
                        filetypes = {
                            "html",
                            -- "typescriptreact",
                            -- "javascriptreact",
                            "css",
                            "sass",
                            "scss",
                            "less",
                            "svelte",
                        },
                    })
                end,

                ["clangd"] = function()
                    -- configure emmet language server
                    local lspconfig = require("lspconfig")
                    lspconfig["clangd"].setup({
                        showOrigin = false,
                        capabilities = capabilities,
                        filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
                    })
                end,
            },
        })

        -- Uncomment everything below this if you'r not using blink.

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        local kind_icons = {
            Text = "",
            Method = "󰆧",
            Function = "󰊕",
            Constructor = "",
            Field = "󰇽",
            Variable = "󰂡",
            Class = "󰠱",
            Interface = "",
            Module = "",
            Property = "󰜢",
            Unit = "",
            Value = "󰎠",
            Enum = "",
            Keyword = "󰌋",
            Snippet = "",
            Color = "󰏘",
            File = "󰈙",
            Reference = "",
            Folder = "󰉋",
            EnumMember = "",
            Constant = "󰏿",
            Struct = "",
            Event = "",
            Operator = "󰆕",
            TypeParameter = "󰅲",
        }
        local luasnip = require("luasnip")
        require("luasnip.loaders.from_vscode").lazy_load()
        luasnip.config.setup({})
        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            experimental = {
                ghost_text = true,
            },
            -- Un comment to auto select the first item in Autocompletion
            -- completion = {
            -- 	completeopt = "menu,menuone,noinsert",
            -- },
            window = {
                -- completion = cmp.config.window.bordered(),
                -- documentation = cmp.config.window.bordered(),
                -- documentation = cmp.config.disable,
            },
            preselect = cmp.PreselectMode.None,
            mapping = cmp.mapping.preset.insert({
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete({}),
                ["<Tab>"] = cmp.mapping.confirm({ select = true }), -- Autocompletion on Tab
                ["<CR>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false, --Set true to make enter key select the first Autocompletion
                }),
            }),
            formatting = {
                format = function(entry, vim_item)
                    -- If the width of the autocompletion menu needs to be increased then
                    -- uncomment the below line
                    -- vim_item.abbr = string.sub(vim_item.abbr, 1, 50) --To limit the autocompletion
                    --width.
                    local lspkind_ok, lspkind = pcall(require, "lspkind")
                    if not lspkind_ok then
                        -- From kind_icons array
                        -- For icons in auto complete

                        -- Comment/Uncomment for icons
                        -- vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
                        -- vim_item.menu = ({
                        --     nvim_lsp = "[LSP]",
                        --     nvim_lua = "[Lua]",
                        --     luasnip = "[LuaSnip]",
                        --     buffer = "[Buffer]",
                        --     latex_symbols = "[LaTeX]",
                        -- })[entry.source.name]
                        vim_item.menu = ({
                            nvim_lsp = "",
                            nvim_lua = "",
                            luasnip = "",
                            buffer = "",
                            latex_symbols = "",
                        })[entry.source.name]
                        return vim_item
                    else
                        -- From lspkind
                        return lspkind.cmp_format()(entry, vim_item)
                    end
                end,
            },

            -- sources = cmp.config.sources({
            --     { name = 'nvim_lsp' },
            --     { name = 'luasnip' }, -- For luasnip users.
            -- }, {
            --         { name = 'buffer' },
            --     })
            sources = cmp.config.sources({
                -- { name = "nvim_lsp", max_item_count = 10 },
                -- { name = "luasnip", max_item_count = 10 }, -- For luasnip users.
                -- { name = "buffer", max_item_count = 10 },
                -- { name = "path", max_item_count = 10 },
                -- For source names in autocomplete menu
                { name = "nvim_lsp" },
                { name = "luasnip" }, -- For luasnip users.
                { name = "buffer" },
                { name = "path" },
                { name = "treesitter" },
                { name = "tmux" },
            }),
        })

        vim.diagnostic.config({
            virtual_text = true,
            underline = false,
            -- update_in_insert = true,
            -- Below virtual text and sign setting helps in pylsp
            -- virtual_text = {
            --    severity = { min = vim.diagnostic.severity.ERROR},
            --  },
            --  signs = {
            --    severity = { min = vim.diagnostic.severity.ERROR},
             -- },
            -- signs = {
                -- text = {
                --     [vim.diagnostic.severity.ERROR] = '',
                --     [vim.diagnostic.severity.WARN] = ' ',
                --     [vim.diagnostic.severity.INFO] = '󰠠 ',
                --     [vim.diagnostic.severity.HINT] = ' ',
                -- }
            -- },
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end,
}
