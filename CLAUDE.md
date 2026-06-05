# Dylanix — Nix Configuration

Flake-based Nix config for three machines, all **standalone home-manager** (no NixOS, no
nix-darwin). Nix manages the CLI/dev toolchain and dotfiles only; GUI apps are installed by
hand on each host.

- **dylanmac** — Apple Silicon mac, home-manager on aarch64-darwin (user `dylan`). GUI apps
  (kitty, VS Code, etc.) installed manually; nix only links their config.
- **dylanpc** — Windows 11 + WSL Ubuntu, home-manager on x86_64-linux (user `dylan`, interactive dev box)
- **dylanserver** — Ubuntu home-manager on aarch64-linux (user `ubuntu`, headless)

Host-specific code uses semantic flags (`isDarwin`, `isServer`, `isWsl`) passed via
`extraSpecialArgs` — see the `mkFlags` helper in `flake.nix`. Never compare hostnames.

## Workflow Discipline

**Before implementing structural changes** (new modules, refactors, architectural changes, moving files, changing import chains), you MUST enter plan mode and get approval. Ask clarifying questions about intent, scope, edge cases, and host implications before writing any code.

**Simple additions** (adding a package, tweaking a setting value, adjusting a keybinding) can proceed directly.

When in doubt, ask. Multiple rounds of Q&A are better than rework.

**Documentation maintenance:** When adding new files, modules, extensions, or changing import chains, update `.claude/architecture.md` to reflect the changes. Keep the file tree, theming section, and tech debt list current. This should happen as part of the work, not as a separate step.

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
lib.mkIf isDarwin { ... }

# BAD — brittle, doesn't convey meaning
lib.mkIf (hostname == "dylanmac") { ... }
```

Preferred flags: `isDarwin`, `isServer`, `isWsl`.

### GUI Apps

Nix never installs GUI apps. Install them by hand (Homebrew/App Store on mac, apt on WSL).
For apps we configure (kitty, VS Code), home-manager only **links the config file** —
`xdg.configFile` for XDG-compliant apps, `home.file."Library/Application Support/…"` for
macOS apps. Do not use `programs.kitty` / `programs.vscode` (they install the binary).

### Module Structure

- **Feature-toggleable modules** (development categories): use proper module system with `mkEnableOption`/`mkOption` and a `config` section.
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
# macOS (dylanmac)
home-manager switch --flake ~/home/nix-config#dylan@dylanmac

# dylanpc (WSL Ubuntu) — run inside WSL
home-manager switch --flake ~/home/nix-config#dylan@dylanpc

# Server (dylanserver) — run on the server
home-manager switch --flake ~/home/nix-config#ubuntu@dylanserver

# On any host, the `nrb` shell alias resolves to the correct switch command.

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
