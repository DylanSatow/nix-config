# Architecture

## Repository Structure

```
nix-config/
├── CLAUDE.md                 # Root instructions (auto-loaded by Claude)
├── flake.nix                 # Entry point: defines all system configurations
├── flake.lock                # Pinned input versions
├── overlays.nix              # pkgs.unstable overlay
│
├── hosts/                    # System-level configuration (NixOS / nix-darwin)
│   ├── common/               # Shared across all hosts
│   │   ├── default.nix       # Aggregates: server.nix + multimedia.nix
│   │   ├── core.nix          # Essential packages (zip, unzip, fonts, btop)
│   │   ├── cli-tools.nix     # Terminal tools (lazygit, yazi, ripgrep, fzf, fd, gh)
│   │   ├── development.nix   # Dev toolchains (Nix, Python, Rust, Go, C/C++)
│   │   ├── multimedia.nix    # Media tools (ffmpeg, poppler, jq)
│   │   └── server.nix        # Orchestrator: imports core + cli-tools + development
│   │
│   ├── dylanpc/              # NixOS x86_64-linux desktop
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
    ├── default.nix           # Root: catppuccin theming, conditional GNOME import
    │
    ├── apps/                 # Application configs (all hosts)
    │   ├── default.nix       # Aggregates all app configs
    │   ├── git.nix           # Git user/email
    │   ├── shell.nix         # Zsh + oh-my-zsh, direnv, zellij, zoxide, aliases
    │   ├── kitty.nix         # Kitty + Alacritty terminal configs
    │   ├── vscode.nix        # VSCode extensions + settings
    │   ├── helix.nix         # Helix editor + LSP configs
    │   ├── firefox.nix       # Firefox profile, bookmarks, privacy, performance
    │   └── nvim/             # Full Neovim setup (see neovim-guide.md)
    │       ├── nvim.nix
    │       ├── init.lua
    │       ├── stylua.toml
    │       └── lua/
    │
    ├── gnome/                # GNOME desktop config (dylanpc only)
    │   ├── default.nix
    │   └── dconf.nix         # Workspaces, keybindings, theming, extensions
    │
    └── server/               # Server user config (dylanserver only)
        ├── default.nix       # Ubuntu user, shell setup, npm PATH
        └── packages.nix      # CLI + dev tools (mirrors common/ — known tech debt)
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

### dylanpc (NixOS)

```
flake.nix
  └── nixosSystem {
        modules = [
          hosts/dylanpc/default.nix    → hosts/common/* + hardware + system + packages
          catppuccin.nixosModules.catppuccin
          home-manager.nixosModules.home-manager {
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
            home-manager.users.dylan.imports = [ home/default.nix ]
          }
        ]
        overlays = [ unstable-overlay ]
      }
```

### dylanserver (standalone home-manager)

```
flake.nix
  └── homeManagerConfiguration {
        modules = [ home/server/default.nix ]
          → shell.nix, git.nix, helix.nix, nvim.nix, packages.nix
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
- **Home level:** `catppuccin.enable = true` in `home/default.nix`
- **GNOME:** Catppuccin GTK theme + Papirus-Dark icons via dconf
- **Neovim:** catppuccin-nvim plugin
- **Terminals:** Catppuccin colors via home-manager integration

All applications should respect this theme. Don't introduce competing color schemes.

## Known Technical Debt

These are areas where the current codebase doesn't meet the standards in CLAUDE.md. Fix them when touching related code:

1. **`home/server/packages.nix`** duplicates packages from `hosts/common/development.nix` and `cli-tools.nix`. Should import shared lists instead.
2. **`hosts/common/server.nix`** is misleadingly named — it's not server-specific, it's the base import orchestrator for all hosts.
3. **Hostname string comparison** (`hostname == "dylanpc"`) used in `home/default.nix` instead of semantic flags.
4. **`with pkgs.unstable;`** scoping used in several package list files instead of explicit prefixes.
5. **Almost everything uses `pkgs.unstable`** — packages should be evaluated and moved to stable where a newer version isn't needed.
6. **`hardware.nix`** mixes auto-generated content with manual NVIDIA/WiFi additions. Manual parts should be in a separate file.
7. **No `lib/` directory** for shared utility functions or custom module options namespace.
8. **Shell alias `nrb`** in `shell.nix` hardcodes `#dylanpc` — doesn't work on other hosts.

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
