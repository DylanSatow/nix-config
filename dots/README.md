# dots — the same setup without Nix

Plain dotfiles for machines where Nix can't be installed (e.g. a work laptop).
They are hand-portable copies of what home-manager generates from `home/`:
identical settings, with every `/nix/store/...` path replaced by a normal
`$PATH` lookup. **`home/` stays the source of truth** — when you change a
module there, mirror the change here.

Layout mirrors `$HOME`, so `install.sh` just symlinks each file into place
(backing up anything already there as `*.bak`):

```bash
git clone git@github.com:DylanSatow/nix-config.git ~/nix-config
~/nix-config/dots/install.sh
```

## What's here

| Path | From | Notes |
|------|------|-------|
| `.config/fish/` | `shell.nix`, `theme.nix` | aliases, `zjc`/`lg` functions, catppuccin theme, starship/zoxide/direnv hooks |
| `.zshrc` | `shell.nix` | fallback for terminals that open zsh (no oh-my-zsh) |
| `.config/wezterm/wezterm.lua` | `wezterm.nix` | launches fish from `/opt/homebrew/bin` / `/usr/local/bin` / `/usr/bin` |
| `.config/zellij/` | `zellij.nix` | zjstatus bar is loaded from its GitHub release URL (cached on first run) |
| `.config/starship.toml` | `starship.nix` | |
| `.config/helix/` | `helix.nix` | incl. catppuccin-mocha theme |
| `.config/lazygit/config.yml` | `lazygit.nix` | catppuccin theme merged in; `LG_CONFIG_FILE` points here on every OS |
| `.config/nvim/` | `home/modules/nvim/` | LazyVim; lazy.nvim + Mason bootstrap themselves |
| `.config/git/config` | `git.nix` | **personal name/email** — override with a work `~/.gitconfig` if needed |
| `.config/glamour/` | `theme.nix` | catppuccin style for `glow`/`gh` markdown |
| `.config/aerospace/`, `.config/karabiner/` | `aerospace.nix`, `karabiner.nix` | mac only |
| `Library/Application Support/Code/User/settings.json` | `vscode.nix` | mac only (linked only on Darwin) |

## Install the tools yourself

Nix normally installs these; on a non-Nix box grab them with brew/apt/cargo:

- shells & prompt: `fish`, `starship`, `zoxide`, `direnv`
- terminal & mux: `wezterm`, `zellij`, `JetBrainsMono Nerd Font`
- editors: `neovim`, `helix`, `lazygit` (+ `git`, `gcc`, `make`, `node`, `unzip` for LazyVim/Mason)
- CLI: `yazi`, `ripgrep`, `ripgrep-all`, `fzf`, `fd`, `gh`, `glow`
- helix language servers (Mason handles nvim's): `pyright`, `rust-analyzer`, `gopls`, `clangd`, `markdown-oxide`, `golangci-lint-langserver`, `nil`

Then make fish the shell wezterm opens (it already is via `wezterm.lua`) or
`chsh -s "$(command -v fish)"`.

## Platform notes

- `zellij/config.kdl` uses `pbcopy`; on Linux switch `copy_command` to `wl-copy` or `xclip`.
- `wezterm.lua` keeps the mac blur/decoration settings; wezterm ignores them elsewhere.
  On Windows, add `config.default_domain = 'WSL:Ubuntu'` (see the `isWsl` branch in `wezterm.nix`).
