# Architecture

## Repository Structure

```
nix-config/
├── CLAUDE.md                 # Root instructions (auto-loaded by Claude)
├── flake.nix                 # Entry point: three home-manager configs + mkFlags helper
├── flake.lock                # Pinned input versions
├── overlays.nix              # pkgs.unstable overlay + direnv-overlay
│
└── home/                     # All configuration is user-level home-manager
    ├── common.nix            # Shared base: imports modules/{theme,packages,shell,git,helix,nvim}
    │                         #   + stateVersion + home-manager.enable
    │
    ├── mac.nix               # dylanmac entry (aarch64-darwin, dylan): common + kitty + vscode + font
    ├── wsl.nix               # dylanpc entry (x86_64-linux WSL, dylan): common + kitty + bash→zsh + font
    ├── server.nix            # dylanserver entry (aarch64-linux, ubuntu): common + npm PATH
    │
    └── modules/              # Composable building blocks — imported explicitly by the above
        ├── theme.nix         # Shared catppuccin settings (mocha/lavender) — CLI tools
        ├── packages.nix      # home.packages — the CLI + development toolchain
        ├── git.nix           # Git user/email
        ├── shell.nix         # Zsh + oh-my-zsh, direnv, zellij, zoxide; flag-based nrb alias
        ├── helix.nix         # Helix editor + LSP configs
        ├── kitty.nix         # kitty.conf via xdg.configFile (Catppuccin baked in); no programs.kitty
        ├── vscode.nix        # VS Code settings.json via home.file (mac path); no programs.vscode
        └── nvim/             # LazyVim — lazy.nvim + Mason own plugins/LSPs (see neovim-guide.md)
            ├── nvim.nix      # installs neovim + runtime build deps; links init.lua/lua/stylua.toml
            ├── init.lua
            ├── stylua.toml
            └── lua/
```

## Flake Inputs

| Input | Source | Purpose |
|-------|--------|---------|
| nixpkgs | NixOS 26.05 | Primary package source (serves linux + darwin) |
| nixpkgs-unstable | nixpkgs unstable | Newer packages via overlay |
| home-manager | release-26.05 | User environment management |
| catppuccin | catppuccin/nix | Catppuccin theming for CLI tools + nvim colorscheme |

## How Hosts Are Built

Every host is a standalone `home-manager.lib.homeManagerConfiguration`. Host identity flows
through `flake.nix`'s `mkFlags` helper, which sets exactly one of `isDarwin` / `isServer` /
`isWsl` per config (passed via `extraSpecialArgs`). Modules branch on these flags instead of
comparing hostnames. The `mkPkgs` helper imports nixpkgs for a system with the unstable
overlay (+ any extras) and `allowUnfree`.

### dylanmac (mac — standalone home-manager)

```
flake.nix
  └── homeManagerConfiguration {
        pkgs = aarch64-darwin + unstable-overlay + direnv-overlay
        extraSpecialArgs = mkFlags { isDarwin = true; }
        modules = [
          home/mac.nix                 → home/common.nix (theme + packages + shell/git/helix/nvim)
                                         + modules/kitty.nix + modules/vscode.nix + nerd font
          catppuccin.homeModules.catppuccin
        ]
      }
```

### dylanpc (WSL Ubuntu — standalone home-manager)

```
flake.nix
  └── homeManagerConfiguration {
        pkgs = x86_64-linux + unstable-overlay
        extraSpecialArgs = mkFlags { isWsl = true; }
        modules = [
          home/wsl.nix                 → home/common.nix + modules/kitty.nix + bash→zsh hop + nerd font
          catppuccin.homeModules.catppuccin
        ]
      }
```

### dylanserver (standalone home-manager)

```
flake.nix
  └── homeManagerConfiguration {
        pkgs = aarch64-linux + unstable-overlay
        extraSpecialArgs = mkFlags { isServer = true; }
        modules = [
          home/server.nix              → home/common.nix + username/homeDir + npm PATH
          catppuccin.homeModules.catppuccin
        ]
      }
```

## Overlay Strategy

`overlays.nix` exports two overlays:

- **`unstable-overlay`** — makes `pkgs.unstable.*` available everywhere (applied to all hosts).
- **`direnv-overlay`** — disables direnv's flaky test suite; applied only on the mac, where the
  check otherwise fails the build.

## GUI Apps & Config Linking

Nix installs **no GUI apps**. They are installed by hand per host (Homebrew/App Store on mac,
apt on WSL). For the apps we configure, home-manager links only the config file:

- **kitty** → `xdg.configFile."kitty/kitty.conf".text` (true XDG). Catppuccin Mocha (lavender
  accent) is baked directly into the file, since the catppuccin HM module can only theme kitty
  through `programs.kitty`, which we don't use.
- **VS Code** → `home.file."Library/Application Support/Code/User/settings.json"`. macOS is not
  XDG, so this lives under `~/Library`, not `~/.config`. Mac-only (imported by `home/mac`).
  Extensions are managed manually inside VS Code (the previous set is listed in `vscode.nix`).

## Neovim

From-scratch LazyVim, identical across all three hosts. Nix installs `neovim` plus the runtime
build prerequisites (`git`, `gcc`, `gnumake`, `nodejs`, `unzip`) and symlinks the Lua config
(`init.lua`, `lua/`, `stylua.toml`) read-only via `xdg.configFile`. Everything else is runtime:

- **lazy.nvim** fetches plugins from git (bootstrapped by `lua/config/lazy.lua`).
- **Mason** installs LSP servers and formatters. (Works on every host because none is NixOS —
  mac, WSL Ubuntu, and Ubuntu server all run Mason's dynamically-linked binaries.)
- `lazy-lock.json` and `~/.local/share/nvim/mason/` stay writable, outside the linked dirs.
- Colorscheme is Catppuccin Mocha via `lua/plugins/colorscheme.lua` (a normal lazy plugin spec).

The old nix-managed approach (`programs.neovim.plugins` linkFarm, `extraPackages` LSP list,
`mason = false` overrides, treesitter `symlinkJoin` parsers) has been removed entirely.

## Theming

**Catppuccin Mocha** with **Lavender** accent:

- **Home level:** `catppuccin.enable = true` in `home/modules/theme.nix` (imported by every host) themes
  terminal CLI tools (bat, btop, fzf, zsh highlighting, etc.).
- **Neovim:** catppuccin colorscheme as a lazy plugin (`lua/plugins/colorscheme.lua`).
- **kitty:** colors baked into `kitty.conf` directly (not via the catppuccin module).

Don't introduce competing color schemes. VS Code theming is now a manually-installed extension.

## Known Technical Debt

These are areas where the current codebase doesn't fully meet the standards in CLAUDE.md. Fix
them when touching related code:

1. **Almost everything uses `pkgs.unstable`** (see `home/modules/packages.nix`) — packages should be
   evaluated and moved to stable where a newer version isn't specifically needed.

## Language Support Matrix (Neovim, via Mason)

| Language | LSP | Formatter | Linter | Treesitter |
|----------|-----|-----------|--------|------------|
| Nix | nil, nixd | alejandra | — | Yes |
| Python | pyright | ruff | ruff | Yes |
| Rust | rust-analyzer | rustfmt | — | — |
| Go | gopls | goimports | golangci-lint | Yes |
| C/C++ | clangd | clang-format | — | Yes |
| Lua | lua-language-server | stylua | — | Yes |
| Markdown | markdown-oxide | — | markdownlint | Yes |
| LaTeX | — | — | — | Yes |
