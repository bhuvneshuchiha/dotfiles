-- return {
-- 'mfussenegger/nvim-dap',
-- dependencies = {
--   -- Creates a beautiful debugger UI
--   'rcarriga/nvim-dap-ui',
--   'nvim-neotest/nvim-nio',
--
--   -- Installs the debug adapters for you
--   'williamboman/mason.nvim',
--   'jay-babu/mason-nvim-dap.nvim',
--
--   -- Add your own debuggers here
--   'leoluz/nvim-dap-go',
--   'mfussenegger/nvim-dap-python',
-- },
-- config = function()
--   local dap = require 'dap'
--   local dapui = require 'dapui'
--
--   require('mason-nvim-dap').setup {
--     -- Makes a best effort to setup the various debuggers with
--     -- reasonable debug configurations
--     automatic_setup = true,
--     automatic_installation = true,
--
--     -- You can provide additional configuration to the handlers,
--     -- see mason-nvim-dap README for more information
--     handlers = {},
--
--     -- You'll need to check that you have the required things installed
--     -- online, please don't ask me how to install them :)
--     ensure_installed = {
--       -- Update this to ensure that you have the debuggers for the langs you want
--       -- 'delve',
--       'debugpy',
--     },
--   }
--
--   -- Basic debugging keymaps, feel free to change to your liking!
--   vim.keymap.set('n', '<leader>0', dap.continue, { desc = 'Debug: Start/Continue' })
--   vim.keymap.set('n', '<leader>9', dap.step_into, { desc = 'Debug: Step Into' })
--   vim.keymap.set('n', '<leader>8', dap.step_over, { desc = 'Debug: Step Over' })
--   vim.keymap.set('n', '<leader>7', dap.step_out, { desc = 'Debug: Step Out' })
--   vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
--   vim.keymap.set('n', '<leader>B', function()
--     dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
--   end, { desc = 'Debug: Set Breakpoint' })
--
--   -- Dap UI setup
--   -- For more information, see |:help nvim-dap-ui|
--   dapui.setup {
--     -- Set icons to characters that are more likely to work in every terminal.
--     --    Feel free to remove or use ones that you like more! :)
--     --    Don't feel like these are good choices.
--     icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
--     controls = {
--       icons = {
--         pause = '⏸',
--         play = '▶',
--         step_into = '⏎',
--         step_over = '⏭',
--         step_out = '⏮',
--         step_back = 'b',
--         run_last = '▶▶',
--         terminate = '⏹',
--         disconnect = '⏏',
--       },
--     },
--   }
--
--   -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
--   vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })
--
--   dap.listeners.after.event_initialized['dapui_config'] = dapui.open
--   dap.listeners.before.event_terminated['dapui_config'] = dapui.close
--   dap.listeners.before.event_exited['dapui_config'] = dapui.close
--
--   -- Install golang specific config
--   require('dap-go').setup()
--   require('dap-python').setup()
-- end,
-- }


---- PRIMEAGEN CONFIG STARTS FROM HERE -----

vim.api.nvim_create_augroup("DapGroup", { clear = true })

local function navigate(args)
    local buffer = args.buf

    local wid = nil
    local win_ids = vim.api.nvim_list_wins() -- Get all window IDs
    for _, win_id in ipairs(win_ids) do
        local win_bufnr = vim.api.nvim_win_get_buf(win_id)
        if win_bufnr == buffer then
            wid = win_id
        end
    end

    if wid == nil then
        return
    end

    vim.schedule(function()
        if vim.api.nvim_win_is_valid(wid) then
            vim.api.nvim_set_current_win(wid)
        end
    end)
end

local function create_nav_options(name)
    return {
        group = "DapGroup",
        pattern = string.format("*%s*", name),
        callback = navigate
    }
end

return {
    {
        "mfussenegger/nvim-dap",
        lazy = false,
        config = function()
            local dap = require("dap")
            dap.set_log_level("DEBUG")

            -- Set the breakpoint.
            -- Start the debugging with f8
            -- open repl
            -- continue
            vim.keymap.set("n", "<F8>", dap.continue, { desc = "Debug: Continue" })
            vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
            vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
            vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
            vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
            vim.keymap.set("n", "<leader>B", function()
                dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
            end, { desc = "Debug: Set Conditional Breakpoint" })
        end
    },


    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            local function layout(name)
                return {
                    elements = {
                        { id = name },
                    },
                    enter = true,
                    size = 40,
                    position = "right",
                }
            end
            local name_to_layout = {
                repl = { layout = layout("repl"), index = 0 },
                stacks = { layout = layout("stacks"), index = 0 },
                scopes = { layout = layout("scopes"), index = 0 },
                console = { layout = layout("console"), index = 0 },
                watches = { layout = layout("watches"), index = 0 },
                breakpoints = { layout = layout("breakpoints"), index = 0 },
            }
            local layouts = {}

            for name, config in pairs(name_to_layout) do
                table.insert(layouts, config.layout)
                name_to_layout[name].index = #layouts
            end

            local function toggle_debug_ui(name)
                dapui.close()
                local layout_config = name_to_layout[name]

                if layout_config == nil then
                    error(string.format("bad name: %s", name))
                end

                dapui.toggle(layout_config.index)
            end

            vim.keymap.set("n", "<leader>dr", function() toggle_debug_ui("repl") end, { desc = "Debug: toggle repl ui" })
            vim.keymap.set("n", "<leader>ds", function() toggle_debug_ui("stacks") end,
                { desc = "Debug: toggle stacks ui" })
            vim.keymap.set("n", "<leader>dw", function() toggle_debug_ui("watches") end,
                { desc = "Debug: toggle watches ui" })
            vim.keymap.set("n", "<leader>db", function() toggle_debug_ui("breakpoints") end,
                { desc = "Debug: toggle breakpoints ui" })
            vim.keymap.set("n", "<leader>dS", function() toggle_debug_ui("scopes") end,
                { desc = "Debug: toggle scopes ui" })
            vim.keymap.set("n", "<leader>dc", function() toggle_debug_ui("console") end,
                { desc = "Debug: toggle console ui" })

            vim.api.nvim_create_autocmd("BufEnter", {
                group = "DapGroup",
                pattern = "*dap-repl*",
                callback = function()
                    vim.wo.wrap = true
                end,
            })

            vim.api.nvim_create_autocmd("BufWinEnter", create_nav_options("dap-repl"))
            vim.api.nvim_create_autocmd("BufWinEnter", create_nav_options("DAP Watches"))

            dapui.setup({
                layouts = layouts,
                enter = true,
            })

            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end

            dap.listeners.after.event_output.dapui_config = function(_, body)
                if body.category == "console" then
                    dapui.eval(body.output) -- Sends stdout/stderr to Console
                end
            end
        end,
    },

    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap",
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("mason-nvim-dap").setup({
                ensure_installed = {
                    "delve",
                    "debugpy",
                    "netcoredbg", -- Add netcoredbg for C#

                },
                automatic_installation = true,
                handlers = {
                    function(config)
                        require("mason-nvim-dap").default_setup(config)
                    end,
                    -- Golang Debugger
                    delve = function(config)
                        table.insert(config.configurations, 1, {
                            args = function() return vim.split(vim.fn.input("args> "), " ") end,
                            type = "delve",
                            name = "file",
                            request = "launch",
                            program = "${file}",
                            -- cwd = vim.fn.getcwd(),
                            outputMode = "remote",
                        })
                        table.insert(config.configurations, 1, {
                            args = function() return vim.split(vim.fn.input("args> "), " ") end,
                            type = "delve",
                            name = "file args",
                            request = "launch",
                            program = "${file}",
                            -- cwd = vim.fn.getcwd(),
                            outputMode = "remote",
                        })
                        require("mason-nvim-dap").default_setup(config)
                    end,
                    -- Python Debugger
                    python = function(config)
                        config.configurations = {
                            {
                                type = "python",
                                request = "launch",
                                name = "Launch file",
                                program = "${file}",
                                pythonPath = function()
                                    return vim.fn.exepath("python")
                                end,
                            },
                            {
                                type = "python",
                                request = "launch",
                                name = "Launch with arguments",
                                program = "${file}",
                                args = function()
                                    return vim.split(vim.fn.input("Arguments: "), " ")
                                end,
                                pythonPath = function()
                                    return vim.fn.exepath("python")
                                end,
                            },
                            {
                                type = "python",
                                request = "launch",
                                name = "Launch module",
                                module = function()
                                    return vim.fn.input("Module name: ")
                                end,
                                pythonPath = function()
                                    return vim.fn.exepath("python")
                                end,
                            },
                            {
                                type = "python",
                                request = "attach",
                                name = "Attach remote",
                                connect = function()
                                    local host = vim.fn.input("Host [127.0.0.1]: ")
                                    if host == "" then host = "127.0.0.1" end
                                    local port = tonumber(vim.fn.input("Port [5678]: ")) or 5678
                                    return { host = host, port = port }
                                end,
                            },
                        }
                        require("mason-nvim-dap").default_setup(config)
                    end,

                    -- .NET debugger
                    -- Has a separate file called netcoredbg.lua for macos

                },
            })
        end,
    },
}
