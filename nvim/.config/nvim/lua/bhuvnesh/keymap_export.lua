local function save_keymaps_to_file(filepath)
    local modes = { "n", "v", "i", "c", "x", "s", "o", "t" } -- Modes to export keymaps for
    local file = io.open(filepath, "w")
    if not file then
        print("Failed to open file: " .. filepath)
        return
    end

    file:write("Neovim Keybindings:\n")
    file:write(string.rep("=", 40) .. "\n")

    for _, mode in ipairs(modes) do
        local keymaps = vim.api.nvim_get_keymap(mode)
        file:write("\nMode: " .. mode .. "\n")
        file:write(string.rep("-", 40) .. "\n")
        for _, map in ipairs(keymaps) do
            file:write(string.format("LHS: %s\tRHS: %s\tDesc: %s\n",
                map.lhs,
                map.rhs or "<N/A>",
                map.desc or "<No description>"
            ))
        end
    end

    file:close()
    print("Keymaps saved to " .. filepath)
end

-- Save keymaps to a file
save_keymaps_to_file(vim.fn.expand("~/.config/nvim/keymaps.txt"))
