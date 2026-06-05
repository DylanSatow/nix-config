# Neovim Configuration Guide

The Neovim setup lives at `home/modules/nvim/` and uses **LazyVim** as a base framework with
**lazy.nvim** for plugin management and **Mason** for LSP servers, formatters, and linters.
Nix's role is deliberately minimal: install the `neovim` binary plus the runtime build
prerequisites, and symlink the Lua config. Everything else is managed at runtime by lazy +
Mason — the same config runs identically on mac, WSL, and the server.

## Architecture

```
home/modules/nvim/
├── nvim.nix              # Nix: installs neovim + build deps; symlinks init.lua/lua/stylua.toml
├── init.lua              # Entry point: require("config.lazy")
├── stylua.toml           # StyLua formatter config
└── lua/
    ├── config/
    │   ├── autocmds.lua  # Autocommands
    │   ├── keymaps.lua   # Custom key mappings
    │   ├── lazy.lua      # lazy.nvim bootstrap and setup
    │   └── options.lua   # Editor options (vim.opt, vim.g)
    └── plugins/
        └── *.lua         # Plugin spec files (one per plugin or group)
```

### How Nix and Lua Interact

`nvim.nix` does only two things:

1. **Installs the binary + build prerequisites** via `programs.neovim.enable` and
   `extraPackages` — `git` (lazy.nvim clones), `gcc`/`gnumake` (treesitter parser
   compilation), `nodejs` and `unzip` (Mason installers). `ripgrep`/`fd`/`tree-sitter` come
   from the shared CLI package set and are already on PATH.
2. **Symlinks the Lua config** read-only via `xdg.configFile."nvim/lua"`, `"nvim/init.lua"`,
   and `"nvim/stylua.toml"`.

**Nix does not manage plugins, LSP servers, formatters, or treesitter parsers.** Those are all
runtime concerns owned by lazy.nvim and Mason. `lazy-lock.json` and
`~/.local/share/nvim/mason/` live outside the symlinked dirs and stay writable.

This works on every host because none runs NixOS — mac, WSL Ubuntu, and Ubuntu server can all
execute Mason's dynamically-linked binaries. (The old nix-linkFarm approach existed only to
work around NixOS's inability to run them.)

## Plugin Management

### Adding a Plugin

Plugins are pure Lua specs now — no Nix involvement.

1. Create or update the plugin's spec file in `lua/plugins/`:
   ```lua
   -- lua/plugins/new-plugin.lua
   return {
     {
       "author/new-plugin.nvim",
       opts = {
         -- configuration here
       },
     },
   }
   ```
2. lazy.nvim fetches it from git on next launch. If it needs an LSP/formatter, let Mason
   install it (via the relevant LazyVim lang extra, or `:Mason`).

### Plugin Spec Conventions

- **One file per plugin or logical group** in `lua/plugins/`. Name the file after the plugin or
  feature (e.g., `telescope.lua`, `colorscheme.lua`, `git.lua`).
- Use the LazyVim plugin spec format. Prefer `opts` over `config` when possible:
  ```lua
  -- GOOD — declarative
  return {
    { "plugin/name", opts = { setting = true } },
  }

  -- OK — when you need imperative setup
  return {
    {
      "plugin/name",
      config = function()
        require("plugin").setup({ setting = true })
      end,
    },
  }
  ```
- To **override a LazyVim default plugin**, use the same plugin name and merge options.
- To **disable a LazyVim default plugin**: `{ "plugin/to-disable", enabled = false }`.

### LazyVim Extras

LazyVim extras are imported in `lua/plugins/extras.lua` via the `spec` table. When adding
language support, prefer the LazyVim extra (`lazyvim.plugins.extras.lang.*`) — it wires up the
LSP, formatter, treesitter, and Mason installation together.

## Lua Style Conventions

### Formatting

- Format all `.lua` files with **StyLua** using the `stylua.toml` config at the nvim root.
- StyLua config: `indent_type = "Spaces"`, `indent_width = 2`.

### General Style

```lua
-- Use local variables for repeated requires
local utils = require("config.utils")

-- Use snake_case for local variables and functions
local function setup_keymaps()
  -- ...
end

-- Use descriptive names for keymaps
vim.keymap.set("n", "<leader>ff", function()
  require("telescope.builtin").find_files()
end, { desc = "Find files" })
```

### Keymaps

- Define custom keymaps in `lua/config/keymaps.lua`.
- Plugin-specific keymaps go in the plugin's spec file using the `keys` field.
- Always include a `desc` field for which-key integration.
- Follow LazyVim's `<leader>` key conventions.

### Options

- Set editor options in `lua/config/options.lua`.
- Use `vim.opt` for option settings, `vim.g` for global variables.

## Treesitter

Parsers are installed and compiled by **nvim-treesitter at runtime** (needs `gcc`/`gnumake`,
provided by `nvim.nix`). Add languages via the treesitter `ensure_installed` opts in a plugin
spec, or rely on the LazyVim lang extras, which add their parser automatically.

## LSP / Formatters / Linters

All managed by **Mason** + LazyVim:

1. Import the LazyVim lang extra for the language in `lua/plugins/extras.lua` (handles LSP +
   formatter + treesitter + Mason install together), or
2. For a custom server, configure `nvim-lspconfig` in a plugin spec and let Mason install it.

Currently configured (via LazyVim lang extras in `extras.lua`): Nix (nil/nixd), Python
(pyright, ruff), Lua (lua-language-server), C/C++ (clangd), Go (gopls), Rust (rust-analyzer),
Markdown (markdown-oxide).

## Theming

**Catppuccin Mocha** is the colorscheme, set in `lua/plugins/colorscheme.lua` — a normal lazy
plugin spec that adds `catppuccin/nvim` and points LazyVim's `colorscheme` opt at it (replacing
the tokyonight default). This keeps nvim consistent with the system-wide Catppuccin theming.
Don't change the colorscheme without considering the global theme.

## Anti-Patterns

1. **Don't reintroduce nix-managed plugins/LSPs.** Plugins come from lazy.nvim; tools from
   Mason. `nvim.nix` only installs the neovim binary + build prerequisites.
2. **Don't put keymaps in `init.lua`.** Use `lua/config/keymaps.lua` or plugin spec `keys` fields.
3. **Don't scatter options across files.** Core options go in `lua/config/options.lua`.
4. **Don't add LSP tools to the shared package sets for Neovim's sake.** Mason owns Neovim's
   toolchain; `home/modules/packages.nix` is for the general dev shell.
