# Dylanix — Nix Configuration

Flake-based multi-system Nix config for three hosts:

- **dylanpc** — NixOS x86_64-linux (GNOME desktop, NVIDIA, gaming)
- **dylanmac** — nix-darwin aarch64-darwin (Homebrew casks, macOS defaults)
- **dylanserver** — standalone home-manager on Ubuntu aarch64-linux (headless)

## Workflow Discipline

**Before implementing structural changes** (new modules, refactors, architectural changes, moving files, changing import chains), you MUST enter plan mode and get approval. Ask clarifying questions about intent, scope, edge cases, and host implications before writing any code.

**Simple additions** (adding a package, tweaking a setting value, adjusting a keybinding) can proceed directly.

When in doubt, ask. Multiple rounds of Q&A are better than rework.

## Core Conventions

### Package Sourcing

- **Stable (`pkgs.*`) is the default.** Only use `pkgs.unstable.*` when a newer version is specifically needed — document why with a comment.
- **Always use explicit prefix:** write `pkgs.unstable.foo`, never `with pkgs.unstable;` scoping. Every package's source must be unambiguous at a glance.

### Formatting

- Format all `.nix` files with **alejandra** before committing.
- Run `nix flake check` to validate.

### Naming

- **Files:** `kebab-case.nix` (e.g., `cli-tools.nix`, `my-module.nix`)
- **Nix attributes:** `camelCase` for custom bindings (e.g., `myPackages`, `enableGaming`)
- Standard nixpkgs/home-manager attribute names follow their existing conventions.

### Host-Specific Code

Use semantic boolean flags via `specialArgs`/`extraSpecialArgs` — not hostname string comparison:

```nix
# GOOD — semantic intent is clear
lib.mkIf isDesktop { ... }

# BAD — brittle, doesn't convey meaning
lib.mkIf (hostname == "dylanpc") { ... }
```

Preferred flags: `isDesktop`, `isDarwin`, `isServer`, `hasNvidia`, `hasGaming`.

### Module Structure

- **Feature-toggleable modules** (gaming, desktop environment, development categories): use proper NixOS module system with `mkEnableOption`/`mkOption` and `config` section.
- **Simple package lists and settings:** flat config with imports is fine.
- Never duplicate package lists across files. Extract shared packages into a common module and import it.

### Nix Idioms

- Use `lib.mkIf` for conditional config blocks, not `if/then/else` in attribute sets.
- Use `lib.mkMerge` to combine multiple conditional configs cleanly.
- Use `lib.optional` / `lib.optionals` for conditional list items, `lib.optionalAttrs` for conditional attrsets.
- Prefer `lib.*` over `builtins.*` when both exist.
- Never use `with lib;` — always qualify: `lib.mkIf`, `lib.optional`, etc.

See [`.claude/nix-style-guide.md`](.claude/nix-style-guide.md) for the full Nix style guide.

## Build Commands

```bash
# NixOS (dylanpc)
sudo nixos-rebuild switch --flake ~/nix-config#dylanpc

# macOS (dylanmac)
darwin-rebuild switch --flake ~/nix-config#dylanmac

# Server (dylanserver) — run on the server
home-manager switch --flake ~/nix-config#ubuntu@dylanserver

# Format all nix files
find . -name '*.nix' -exec alejandra {} +

# Validate flake
nix flake check
```

## Detailed Guides

These files contain comprehensive guidance — consult them when working in their respective areas:

- [`.claude/nix-style-guide.md`](.claude/nix-style-guide.md) — Nix language idioms, module patterns, anti-patterns, and formatting rules
- [`.claude/neovim-guide.md`](.claude/neovim-guide.md) — LazyVim framework, plugin management, Lua conventions, nvim.nix integration
- [`.claude/architecture.md`](.claude/architecture.md) — Full file map, import chains, overlay strategy, theming, host differences

## Quality Standards

This CLAUDE.md prescribes **ideal patterns**, not current state. Existing code may violate these standards — that's tech debt to fix, not precedent to follow. When refactoring or writing new code, always follow these guidelines even if surrounding code doesn't.
