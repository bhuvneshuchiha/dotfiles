# AGENTS.md

## Build/Lint/Test
- Build: `nvim --headless -c "Lazy install" -c "qa"`
- Lint: `luacheck .` (ensure luacheck is installed)
- Test: `nvim --headless -u test/init.lua -c "dofile('test/spec/my_test.lua')"`
- Single test: Run specific test file with `nvim --headless -u test/init.lua -c "dofile('test/spec/specific_test.lua')"`

## Code Style
- Lua: 2-space indent, snake_case for variables/functions
- Imports: Use `require()` with absolute paths from `lua/`
- Formatting: Use `stylua` if configured
- Types: Use Lua 5.1 with `---@type` annotations
- Naming: Modules in `lua/` match filename (e.g., `lua/bhuvnesh/mymodule.lua` → `require('bhuvnesh.mymodule')`)
- Error handling: Use `pcall()` for critical operations

## Tools
- LSP: Use `nvim-lspconfig` with `mason.nvim`
- Formatting: `null-ls` with Lua formatter

## Special Rules
- Follow Neovim plugin best practices for performance
- Avoid global variables, use module tables
- Document public APIs with `--@usage` comments