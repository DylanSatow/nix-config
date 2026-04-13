# Neovim Configuration Guide

The Neovim setup lives at `home/apps/nvim/` and uses **LazyVim** as a base framework with **lazy.nvim** for plugin management. All external tooling (LSPs, formatters, linters) is provided via Nix — Mason is explicitly disabled.

## Architecture

```
home/apps/nvim/
├── nvim.nix              # Nix integration: plugins, extraPackages, xdg.configFile
├── init.lua              # Entry point: bootstraps lazy.nvim, loads config + plugins
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

`nvim.nix` does three things:

1. **Installs plugins** via `programs.nixvim` is NOT used — instead, raw plugin packages are listed in `plugins` within a `programs.neovim` setup using `pkgs.vimPlugins.*`.
2. **Provides external tools** via `extraPackages` — language servers, formatters, linters, tree-sitter CLI. These are on Neovim's PATH at runtime.
3. **Symlinks Lua config** via `xdg.configFile."nvim"` pointing to the `lua/` directory and `init.lua`.

Because Mason is disabled, **never** configure a plugin to auto-install tools. All tools must come from `extraPackages` in `nvim.nix`.

## Plugin Management

### Adding a Plugin

1. Add the vim plugin package to the plugins list in `nvim.nix`:
   ```nix
   pkgs.vimPlugins.new-plugin-nvim
   ```

2. If the plugin needs external tools (LSP, formatter, etc.), add them to `extraPackages`:
   ```nix
   extraPackages = [
     pkgs.some-language-server
   ];
   ```

3. Create or update the plugin's spec file in `lua/plugins/`:
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

### Plugin Spec Conventions

- **One file per plugin or logical group** in `lua/plugins/`. Name the file after the plugin or feature (e.g., `telescope.lua`, `lsp.lua`, `git.lua`).
- Use the LazyVim plugin spec format. Prefer `opts` over `config` when possible:
  ```lua
  -- GOOD — declarative
  return {
    {
      "plugin/name",
      opts = {
        setting = true,
      },
    },
  }

  -- OK — when you need imperative setup
  return {
    {
      "plugin/name",
      config = function()
        require("plugin").setup({
          setting = true,
        })
      end,
    },
  }
  ```

- To **override a LazyVim default plugin**, use the same plugin name and merge options:
  ```lua
  return {
    {
      "nvim-telescope/telescope.nvim",
      opts = {
        defaults = {
          layout_strategy = "vertical",
        },
      },
    },
  }
  ```

- To **disable a LazyVim default plugin**:
  ```lua
  return {
    { "plugin/to-disable", enabled = false },
  }
  ```

### LazyVim Extras

LazyVim extras are imported in `lua/config/lazy.lua` via the `spec` table. When adding language support, check if LazyVim has an extra for it before manually configuring LSP/formatter/treesitter.

## Lua Style Conventions

### Formatting

- Format all `.lua` files with **StyLua** using the `stylua.toml` config at the nvim root.
- StyLua config: `indent_type = "Spaces"`, `indent_width = 2`.

### General Style

```lua
-- Use local variables for repeated requires
local utils = require("config.utils")

-- Prefer string keys for readability in opts tables
opts = {
  theme = "catppuccin",
  section_separators = { left = "", right = "" },
}

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

Treesitter parsers are configured in `nvim.nix` via `ensure_installed` in the treesitter plugin spec within `lua/config/lazy.lua`. The parsers themselves are installed by Nix.

Currently installed parsers: C, C++, Lua, Python, Go, Markdown, LaTeX, YAML, HTML.

When adding a new language, add its parser to the `ensure_installed` list.

## LSP Configuration

LSP servers are:
1. Installed via `extraPackages` in `nvim.nix`
2. Configured in LazyVim's built-in LSP setup or via plugin specs in `lua/plugins/`

Currently configured LSPs:
- **Nix:** nil, nixd
- **Python:** pyright (type checking), ruff (linting/formatting)
- **Lua:** lua-language-server
- **C/C++:** clangd
- **Go:** gopls
- **Rust:** rust-analyzer (via LazyVim extra)
- **Markdown:** markdown-oxide

When adding a new LSP:
1. Add the server package to `extraPackages` in `nvim.nix`
2. If LazyVim has an extra for the language, import it
3. Otherwise, configure via `nvim-lspconfig` in a plugin spec file

## Theming

The Neovim config uses **Catppuccin Mocha** as the primary colorscheme, consistent with the system-wide Catppuccin theming managed by home-manager. The catppuccin-nvim plugin is included in the plugin list.

Don't change the colorscheme without considering the system-wide theme. Catppuccin is applied globally via `home/default.nix`.

## Anti-Patterns

1. **Never use Mason.** Mason is explicitly disabled. All tools come from Nix.
2. **Never use `ensure_installed` in plugin configs** that trigger tool downloads. Treesitter parsers are the exception (managed by Nix).
3. **Don't put keymaps in `init.lua`.** Use `lua/config/keymaps.lua` or plugin spec `keys` fields.
4. **Don't scatter options across files.** Core options go in `lua/config/options.lua`.
5. **Don't add plugins without the Nix package.** Every plugin must exist in `nvim.nix`'s plugin list, not just in a Lua spec file.
6. **Don't duplicate tool installations.** If a tool is in `extraPackages`, don't also add it to `hosts/common/development.nix` for Neovim's sake — `extraPackages` handles the Neovim PATH.
