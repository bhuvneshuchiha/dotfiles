# nvim-treesitter + nvim-treesitter-textobjects Fix

**Date:** 2026-04-12

---

## The Error

```
Failed to source `.../nvim-treesitter-textobjects/plugin/nvim-treesitter-textobjects.vim`

module 'nvim-treesitter.configs' not found
```

---

## Root Causes

There were two compounding problems in `lua/bhuvnesh/lazy/treesitter.lua`.

### 1. Malformed `dependencies` table

The dependency spec was written like this:

```lua
dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "master",   -- bare key on the outer table
    lazy = false,        -- bare key on the outer table
},
```

In Lua, `branch` and `lazy` here become keys on the `dependencies` table itself,
**not** fields of the plugin spec for `nvim-treesitter-textobjects`. lazy.nvim
never received a proper spec for the dependency, so it could not enforce load
order — `nvim-treesitter-textobjects` was sourced before `nvim-treesitter` was
on the runtime path.

### 2. `nvim-treesitter.configs` was missing from the installed version

`nvim-treesitter-textobjects` unconditionally requires `nvim-treesitter.configs`
at the top of its Lua entry point:

```lua
local configs = require "nvim-treesitter.configs"
```

The locally installed `nvim-treesitter` (on `master`) had diverged from origin
and was missing `configs.lua` entirely — it had been temporarily removed during
the new API rewrite. Once `nvim-treesitter` was reset to `origin/master`,
`configs.lua` was present again.

---

## The Fix

### Code change — `lua/bhuvnesh/lazy/treesitter.lua`

Wrap the dependency in its own table so `branch` and `lazy` are fields of that
plugin spec:

```lua
-- BEFORE (broken)
dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "master",
    lazy = false,
},

-- AFTER (correct)
dependencies = {
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "master",
        lazy = false,
    },
},
```

### Plugin update — `nvim-treesitter`

The local install had diverged from `origin/master`. It was reset:

```sh
git fetch origin master
git reset --hard origin/master
```

After this, `configs.lua` was present at:
`lua/nvim-treesitter/configs.lua`

---

## Plugin Versions That Work

| Plugin | Branch | Commit | Commit Date |
|--------|--------|--------|-------------|
| `nvim-treesitter/nvim-treesitter` | `master` | `cf12346a3414fa1b06af75c79faebe7f76df080a` | 2026-03-23 |
| `nvim-treesitter/nvim-treesitter-textobjects` | `master` | `5ca4aaa6efdcc59be46b95a3e876300cfead05ef` | 2025-10-31 |

> **Note:** `nvim-treesitter-textobjects` has no release tags — it is
> tracking-only on `master`. `nvim-treesitter` has tags (`v0.9.x`, `v0.10.0`)
> but the config is intentionally pinned to `master` per the comment in
> `treesitter.lua`: *"very important and do not use lazy = false"*.

---

## Key Takeaway

When specifying a lazy.nvim dependency with additional fields (`branch`, `lazy`,
`event`, etc.), always wrap it in a subtable `{}`. A bare string entry is valid
only when no extra fields are needed:

```lua
-- OK for a plain dependency with no extra config
dependencies = { "some/plugin" }

-- Required when adding any fields
dependencies = {
    { "some/plugin", branch = "main", lazy = false }
}
```

