# Architecture

## Repository Structure

```
nix-config/
├── CLAUDE.md                 # Root instructions (auto-loaded by Claude)
├── flake.nix                 # Entry point: defines all configs + mkFlags helper
├── flake.lock                # Pinned input versions
├── overlays.nix              # pkgs.unstable overlay
│
├── lib/                      # Shared, context-agnostic helpers
│   └── package-sets.nix      # cliTools + development package lists, consumed by
│                             #   both system modules and standalone home configs
│
├── hosts/                    # System-level configuration (NixOS / nix-darwin)
│   ├── common/               # Shared across system hosts
│   │   ├── default.nix       # Aggregates: server.nix + multimedia.nix
│   │   ├── core.nix          # Essential packages (zip, unzip, fonts, btop)
│   │   ├── cli-tools.nix     # = lib/package-sets.cliTools ++ [zellij]
│   │   ├── development.nix   # = lib/package-sets.development ++ [texliveFull]
│   │   ├── multimedia.nix    # Media tools (ffmpeg, poppler, jq)
│   │   └── server.nix        # Orchestrator: imports core + cli-tools + development
│   │
│   ├── nixos-pc/             # NixOS x86_64-linux desktop — ARCHIVED (machine now runs WSL)
│   │   ├── default.nix       # Imports: common + hardware + system + packages
│   │   ├── hardware.nix      # Auto-generated hardware config (DO NOT EDIT)
│   │   ├── system.nix        # Boot, GNOME, services, users, networking
│   │   └── packages.nix      # Desktop/gaming apps (Steam, Discord, VSCode, Docker)
│   │
│   └── dylanmac/             # nix-darwin aarch64-darwin
│       ├── default.nix       # Imports: common + homebrew + system
│       ├── system.nix        # macOS defaults, dock, keyboard, Finder
│       └── homebrew.nix      # Homebrew casks (33 macOS GUI apps)
│
└── home/                     # User-level configuration (home-manager)
    ├── default.nix           # Entry for NixOS + darwin: imports theme + apps + (isDesktop) gnome
    ├── theme.nix             # Shared catppuccin settings (mocha/lavender) — all configs
    │
    ├── common/               # Shared base for STANDALONE home-manager (server + WSL)
    │   ├── default.nix       # Imports theme + packages + shell/git/helix/nvim; stateVersion
    │   └── packages.nix      # home.packages = lib/package-sets.cliTools ++ development
    │
    ├── apps/                 # Application configs
    │   ├── default.nix       # Aggregates all app configs (used by home/default.nix)
    │   ├── git.nix           # Git user/email
    │   ├── shell.nix         # Zsh + oh-my-zsh, direnv, zellij, zoxide; flag-based nrb alias
    │   ├── kitty.nix         # Kitty + Alacritty (isDarwin option tweak)
    │   ├── vscode.nix        # VSCode extensions + settings
    │   ├── helix.nix         # Helix editor + LSP configs
    │   ├── firefox.nix       # Firefox profile, bookmarks, privacy, performance
    │   └── nvim/             # Full Neovim setup (see neovim-guide.md)
    │       ├── nvim.nix
    │       ├── init.lua
    │       ├── stylua.toml
    │       └── lua/
    │
    ├── gnome/                # GNOME desktop config (isDesktop / nixos-pc only)
    │   ├── default.nix       # GTK theme, extensions list, wallpaper
    │   ├── dconf.nix         # Workspaces, keybindings, theming, extension settings
    │   ├── colors.nix        # Catppuccin Mocha palette — single source for all extension colors
    │   └── catppuccin-shell-theme.nix  # Fetches Catppuccin GTK/Shell theme derivation
    │
    ├── server/               # dylanserver standalone HM (aarch64, user ubuntu)
    │   └── default.nix       # imports ../common + username/homeDir + npm PATH
    │
    └── wsl/                  # dylanpc standalone HM (x86_64 WSL, user dylan)
        └── default.nix       # imports ../common + kitty + username/homeDir + nerd font
```

## Flake Inputs

| Input | Source | Purpose |
|-------|--------|---------|
| nixpkgs | NixOS 25.11 | Primary package source |
| nixpkgs-unstable | nixpkgs unstable | Newer packages via overlay |
| nixpkgs-darwin-pkgs | NixOS 25.11 | Darwin-specific packages |
| home-manager | release-25.11 | User environment management |
| nix-darwin | nix-darwin | macOS system management |
| nix-homebrew | nix-homebrew | Homebrew integration for macOS |
| stylix | stylix | System-wide theming |
| catppuccin | catppuccin/nix | Catppuccin color scheme |
| nix4vscode | nix4vscode | VSCode extension management |

## How Hosts Are Built

Host identity flows through `flake.nix`'s `mkFlags` helper, which sets exactly one of
`isDesktop` / `isDarwin` / `isServer` / `isWsl` per config (passed via `(extra)specialArgs`).
Modules branch on these flags instead of comparing hostnames.

### dylanpc (WSL Ubuntu — standalone home-manager)

```
flake.nix
  └── homeManagerConfiguration {
        pkgs = x86_64-linux + unstable-overlay
        extraSpecialArgs = mkFlags { isWsl = true; }
        modules = [
          home/wsl/default.nix         → home/common (theme + packages + shell/git/helix/nvim)
                                         + home/apps/kitty.nix + nerd font
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
          home/server/default.nix      → home/common (theme + packages + shell/git/helix/nvim)
                                         + username/homeDir + npm PATH
          catppuccin.homeModules.catppuccin
        ]
      }
```

### nixos-pc (NixOS — archived)

```
flake.nix
  └── nixosSystem {
        modules = [
          hosts/nixos-pc/default.nix   → hosts/common/* + hardware + system + packages
          catppuccin.nixosModules.catppuccin
          home-manager.nixosModules.home-manager {
            extraSpecialArgs = mkFlags { isDesktop = true; }
            home-manager.users.dylan.imports = [ home/default.nix ]
          }
        ]
        overlays = [ unstable-overlay ]
      }
```

### dylanmac (nix-darwin)

```
flake.nix
  └── darwinSystem {
        modules = [
          hosts/dylanmac/default.nix   → hosts/common/* + homebrew + system
          nix-homebrew.darwinModules.nix-homebrew
          home-manager.darwinModules.home-manager {
            extraSpecialArgs = mkFlags { isDarwin = true; }
            home-manager.users.dylan.imports = [ home/default.nix ]
          }
        ]
        overlays = [ unstable-overlay ]
      }
```

## Overlay Strategy

Single overlay in `overlays.nix`:

```nix
unstable-overlay = system: final: prev: {
  unstable = import nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };
};
```

This makes `pkgs.unstable.*` available everywhere. Applied to all three host configurations.

## Theming

**Catppuccin Mocha** with **Lavender** accent, applied globally:

- **System level:** catppuccin NixOS/darwin module
- **Home level:** `catppuccin.enable = true` in `home/theme.nix` (imported by every config — NixOS/darwin via `home/default.nix`, standalone HM via `home/common`)
- **GNOME:** Catppuccin GTK theme + Papirus-Dark icons via dconf. Extension colors sourced from `home/gnome/colors.nix`
- **GNOME extensions:** Dash to Dock, Arc Menu (Runner/spotlight), Space Bar, Vitals, Blur my Shell — all themed via `colors.nix`
- **Neovim:** catppuccin-nvim plugin
- **Terminals:** Catppuccin colors via home-manager integration

All applications should respect this theme. Don't introduce competing color schemes. When adding new GNOME extensions, source colors from `home/gnome/colors.nix` rather than hardcoding.

## Known Technical Debt

These are areas where the current codebase doesn't meet the standards in CLAUDE.md. Fix them when touching related code:

1. ~~**`home/server/packages.nix`** duplicates packages from common.~~ **Resolved** — package lists live in `lib/package-sets.nix`, consumed by both system modules and `home/common/packages.nix`.
2. **`hosts/common/server.nix`** is misleadingly named — it's not server-specific, it's the base import orchestrator for all system hosts.
3. ~~**Hostname string comparison.**~~ **Resolved** — replaced by semantic flags (`isDesktop`/`isDarwin`/`isServer`/`isWsl`) via the `mkFlags` helper in `flake.nix`.
4. **`with pkgs.unstable;`** scoping still used in some package list files (e.g. `hosts/nixos-pc/packages.nix`, `core.nix`, `multimedia.nix`). New shared file `lib/package-sets.nix` uses explicit prefixes; migrate the rest when touched.
5. **Almost everything uses `pkgs.unstable`** — packages should be evaluated and moved to stable where a newer version isn't needed.
6. **`hardware.nix`** (`hosts/nixos-pc/`) mixes auto-generated content with manual NVIDIA/WiFi additions. Manual parts should be in a separate file. (Archived host — low priority.)
7. ~~**No `lib/` directory.**~~ **Resolved** — `lib/package-sets.nix` added; extend it for future shared helpers.
8. ~~**Shell alias `nrb` hardcodes `#dylanpc`.**~~ **Resolved** — `nrb` in `shell.nix` now branches on host flags for all four configs.

## Language Support Matrix

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
