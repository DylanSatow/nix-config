# Nix Style Guide

Comprehensive guide for writing clean, idiomatic Nix in this configuration. These are prescriptive standards — follow them for all new and refactored code.

## Formatting

- **Formatter:** alejandra (provided by the development set in `lib/package-sets.nix`)
- Run `alejandra` on every `.nix` file before committing. No exceptions.
- Let alejandra handle indentation, line breaks, and spacing — don't fight it.

## Package Sourcing

### Rules

1. **Default to stable** (`pkgs.*`). The flake pins nixpkgs to 25.11.
2. **Unstable is opt-in** (`pkgs.unstable.*`) — only when a newer version is specifically required.
3. When using unstable, add a brief comment explaining why:
   ```nix
   pkgs.unstable.claude-code  # needs latest version for MCP support
   ```
4. **Always use explicit prefix.** Never use `with pkgs;` or `with pkgs.unstable;` to scope package lists.

   ```nix
   # GOOD — source is unambiguous
   environment.systemPackages = [
     pkgs.zip
     pkgs.unzip
     pkgs.unstable.btop  # unstable has better GPU monitoring
   ];

   # BAD — unclear where packages come from
   environment.systemPackages = with pkgs.unstable; [
     zip
     unzip
     btop
   ];
   ```

5. **Never mix `with` scoping with explicit prefixes** in the same list.

### Overlay

The `overlays.nix` file provides `unstable-overlay` (makes `nixpkgs-unstable` available as `pkgs.unstable`, applied everywhere) and `direnv-overlay` (disables direnv's flaky tests, applied on the mac only). Don't create additional overlays unless building custom derivations.

## Module Patterns

### When to Use the Full Module System

Use `mkEnableOption`/`mkOption` + `config` for **feature-toggleable functionality**:

```nix
# home/modules/datascience.nix
{ config, lib, pkgs, ... }:

let
  cfg = config.dylanix.datascience;
in {
  options.dylanix.datascience = {
    enable = lib.mkEnableOption "data-science toolchain (jupyter, numpy stack)";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.unstable.jupyter
      pkgs.python3Packages.numpy
      pkgs.python3Packages.pandas
    ];
  };
}
```

Good candidates for full modules: optional development language groups, heavyweight toolchains a host can opt into.

### When Flat Config Is Fine

For simple, always-on package lists or settings that don't need toggling:

```nix
# home/modules/packages.nix
{ pkgs, ... }: {
  home.packages = [
    pkgs.zip
    pkgs.unzip
  ];
}
```

### Import Organization

- Every directory with multiple `.nix` files should have a `default.nix` that aggregates imports.
- Imports should form a clear tree — avoid circular or diamond dependencies.
- Name files by their concern, not by their host: `gaming.nix` not `dylanpc-extras.nix`.

## Host-Specific Code

### specialArgs Flags

Pass semantic boolean flags, not hostname strings:

```nix
# In flake.nix, via the mkFlags helper
extraSpecialArgs = mkFlags {
  isDarwin = true;
  # isServer / isWsl default to false
};
```

Then use them in modules:

```nix
{ lib, isDarwin, isWsl, ... }: {
  config = lib.mkMerge [
    (lib.mkIf isDarwin {
      home.packages = [ pkgs.unstable.nerd-fonts.jetbrains-mono ];
    })
    (lib.mkIf isWsl {
      fonts.fontconfig.enable = true;
    })
  ];
}
```

### Platform Detection

For platform-level differences (Linux vs Darwin), prefer `pkgs.stdenv.isDarwin` / `pkgs.stdenv.isLinux` over custom flags — these are always accurate:

```nix
{ pkgs, lib, ... }: {
  home.packages = lib.optionals pkgs.stdenv.isLinux [
    pkgs.xclip
  ] ++ lib.optionals pkgs.stdenv.isDarwin [
    pkgs.darwin.apple_sdk.frameworks.Security
  ];
}
```

## Nix Language Idioms

### Conditionals

```nix
# Conditional config blocks — use mkIf
config = lib.mkIf someCondition {
  services.foo.enable = true;
};

# Multiple conditions — use mkMerge
config = lib.mkMerge [
  (lib.mkIf condA { ... })
  (lib.mkIf condB { ... })
];

# Conditional list items
packages = [
  pkgs.coreutils
] ++ lib.optionals isWsl [
  pkgs.unstable.nerd-fonts.jetbrains-mono
];

# Conditional attrset fields
settings = {
  font_size = 20;
} // lib.optionalAttrs isDarwin {
  macos_option_as_alt = "yes";
};

# BAD — don't use if/then/else in attrsets
settings = if isDarwin then { macos_option_as_alt = "yes"; } else {};
```

### Attribute Access

```nix
# GOOD — use lib-qualified names
lib.mkIf
lib.mkMerge
lib.optional
lib.optionals
lib.optionalAttrs
lib.mkEnableOption
lib.mkOption
lib.types

# BAD — never use unqualified `with lib;`
with lib;
mkIf ...

# BAD — avoid builtins when lib equivalent exists
builtins.filter  # use lib.filter
builtins.map     # use lib.map (or just map in list context)
```

### Let Bindings

Use `let ... in` for values referenced more than once:

```nix
let
  pythonPkgs = [
    pkgs.unstable.python3  # need 3.13 features
    pkgs.unstable.ruff
    pkgs.unstable.pyright
  ];
in {
  environment.systemPackages = pythonPkgs;
  # ... use pythonPkgs elsewhere
}
```

### String Interpolation

```nix
# GOOD — use multi-line strings for shell scripts and long text
programs.zsh.initExtra = ''
  export PATH="${pkgs.nodejs}/bin:$PATH"
  eval "$(${pkgs.direnv}/bin/direnv hook zsh)"
'';

# GOOD — simple interpolation
description = "User ${username} configuration";

# BAD — concatenation instead of interpolation
description = "User " + username + " configuration";
```

## Anti-Patterns to Avoid

1. **Package duplication.** Never list the same package in multiple files. Extract to a shared module (e.g. `lib/package-sets.nix`).
2. **Hardcoded paths.** Use `config.home.homeDirectory` or `~/` instead of `/home/dylan` or `/Users/dylan`.
3. **Hostname string matching.** Use semantic flags (`isDarwin`, `isServer`, `isWsl`) not `hostname == "dylanmac"`.
4. **`with` for package scoping.** Always use explicit prefix.
5. **`with lib;`** at module level. Always qualify: `lib.mkIf`, `lib.optional`.
6. **Installing GUI apps via nix.** GUI apps are installed by hand; nix only links their config (see CLAUDE.md → GUI Apps).
7. **Misleading file names.** A file's name should describe its concern, not which hosts happen to import it.
8. **Unused imports or dead code.** Remove them entirely — no commented-out blocks, no `_unused` variables.

## Type Annotations (When Writing Module Options)

Always specify types for custom options:

```nix
options.dylanix.myModule = {
  enable = lib.mkEnableOption "my module";

  packages = lib.mkOption {
    type = lib.types.listOf lib.types.package;
    default = [];
    description = "Additional packages to install";
  };

  fontSize = lib.mkOption {
    type = lib.types.int;
    default = 12;
    description = "Font size for the terminal";
  };
};
```

## Flake Hygiene

- Pin all inputs to specific branches or releases (e.g., `nixpkgs/release-25.11`), never `main`/`master`.
- Use `follows` to deduplicate nixpkgs across inputs when possible.
- Keep `flake.lock` committed — it ensures reproducible builds.
- Add new inputs only when they provide real value. Prefer nixpkgs packages over standalone flakes.
