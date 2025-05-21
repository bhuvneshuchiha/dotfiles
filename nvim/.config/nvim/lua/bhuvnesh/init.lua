--NOTE:Below two line disable netrw flash and these 2 lines need to be at the top
--of this file.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

--NOTE:This is to enable netrw
-- vim.g.netrw_browse_split = 0
-- vim.g.netrw_banner = 0
-- vim.g.netrw_winsize = 25

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.updatetime = 50
-- vim.o.laststatus = 3

require("bhuvnesh.set")
require("bhuvnesh.remap")
require("bhuvnesh.lazy_init")

--
vim.opt.termguicolors = true
vim.o.wrap = false


-- Set the sign column to a fixed width of 2
vim.opt.signcolumn = "yes"

vim.api.nvim_set_hl(0, "Cursor", { fg = "NONE", bg = "NONE" })
vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "none" })

local augroup = vim.api.nvim_create_augroup
local ThePrimeagenGroup = augroup("ThePrimeagen", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

function R(name)
    require("plenary.reload").reload_module(name)
end

vim.filetype.add({
    extension = {
        templ = "templ",
    },
})


autocmd("TextYankPost", {
    group = yank_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 40,
        })
    end,
})

autocmd({ "BufWritePre" }, {
    group = ThePrimeagenGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

--HACK:
-- Search and replace word under the cursor
vim.keymap.set("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]])

-- HACK:    TO FORMAT USING LSP
--To autoformat files using Neovim's native LSP.
-- vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]


-- FASTEST LSP FORMATTER
-- vim.api.nvim_create_augroup("LspFormatting", { clear = true })
-- vim.api.nvim_create_autocmd("BufWritePre", {
--     pattern = "*",
--     group = "LspFormatting",
--     callback = function()
--         vim.lsp.buf.format({
--             async = true,
--             timeout_ms = 500,
--             filter = function(clients)
--                 return vim.tbl_filter(function(client)
--                     return pcall(function(_client)
--                         return _client.config.settings.autoFixOnSave or false
--                     end, client) or false
--                 end, clients)
--             end,
--         })
--     end,
-- })

-- If you wanna trigger format by a key rather than on save.
-- vim.keymap.set("n", "<leader>ft", function()
--     vim.lsp.buf.format({
--         async = true,
--         timeout_ms = 500,
--         filter = function(clients)
--             return vim.tbl_filter(function(client)
--                 return pcall(function(_client)
--                     return _client.config.settings.autoFixOnSave or false
--                 end, client) or false
--             end, clients)
--         end,
--     })
-- end, { desc = "Trigger LSP formatting" })



-- For cursor flickering when saving a file
-- vim.api.nvim_create_autocmd({ "BufWritePre" }, {
--     pattern = "*",
--     callback = function()
--         -- save current position
--         local pos = vim.api.nvim_win_get_cursor(0)
--
--         -- strip trailing whitespace
--         vim.cmd([[%s/\s\+$//e]])
--
--         -- restore cursor position
--         vim.api.nvim_win_set_cursor(0, pos)
--     end
-- })

--Commented ----> :NOTE:
local o = vim.o
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.clipboard = "unnamed,unnamedplus"

vim.opt.ignorecase = true
vim.opt.splitbelow = true

-- removes trailing whitespace on save
-- vim.api.nvim_create_autocmd("BufWritePre", {
--     callback = function()
--         local save_cursor = vim.fn.getpos(".")
--         vim.cmd([[%s/\s\+$//e]])
--         vim.fn.setpos(".", save_cursor)
--     end,
-- })


-- IMPORTANT **RestoreCursorPosition**
-- function RestoreCursorPosition()
--     local line = vim.fn.line("'\"")
--     if
--         line > 1
--         and line <= vim.fn.line("$")
--         and vim.bo.filetype ~= "commit"
--         and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
--     then
--         vim.cmd('normal! g`"')
--     end
-- end
--
-- if vim.fn.has("autocmd") then
--     vim.cmd([[
--     autocmd BufReadPost * lua RestoreCursorPosition()
--   ]])
-- end


-- Another way to restore cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function(args)
        local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
        local line_count = vim.api.nvim_buf_line_count(args.buf)
        if mark[1] > 0 and mark[1] <= line_count then
            vim.cmd('normal! g`"zz')
        end
    end,
})


-- Set Netrw file menu to bold
vim.api.nvim_create_autocmd("FileType", {
    pattern = "netrw",
    command = "highlight Directory cterm=bold gui=bold",
})

--To run jupiter lab, point neovim to this virtual env
-- vim.g.python3_host_prog = vim.fn.expand("~/.virtualenvs/neovim/bin/python3")
-- vim.keymap.set("n", "<localleader>ip", function()
--     local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
--     if venv ~= nil then
--         -- in the form of /home/benlubas/.virtualenvs/VENV_NAME
--         venv = string.match(venv, "/.+/(.+)")
--         vim.cmd(("MoltenInit %s"):format(venv))
--     else
--         vim.cmd("MoltenInit python3")
--     end
-- end, { desc = "Initialize Molten for python3", silent = true })

--LSP autocmd
autocmd("LspAttach", {
    group = ThePrimeagenGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function()
            vim.lsp.buf.definition()
        end, opts)
        vim.keymap.set("n", "K", function()
            vim.lsp.buf.hover()
        end, opts)
        vim.keymap.set("n", "<leader>vws", function()
            vim.lsp.buf.workspace_symbol()
        end, opts)
        vim.keymap.set("n", "<leader>vd", function()
            vim.diagnostic.open_float()
        end, opts)
        vim.keymap.set("n", "<leader>vca", function()
            vim.lsp.buf.code_action()
        end, opts)
        vim.keymap.set("n", "<leader>vrr", function()
            vim.lsp.buf.references()
        end, opts)
        vim.keymap.set("n", "<leader>vrn", function()
            vim.lsp.buf.rename()
        end, opts)
        vim.keymap.set("i", "<C-h>", function()
            vim.lsp.buf.signature_help()
        end, opts)
        vim.keymap.set("n", "[d", function()
            vim.diagnostic.goto_next()
        end, opts)
        vim.keymap.set("n", "]d", function()
            vim.diagnostic.goto_prev()
        end, opts)
    end,
})

-- for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight") or {}) do
--   vim.api.nvim_set_hl(0, group, {})
-- end


