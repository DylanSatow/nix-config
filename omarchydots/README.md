# omarchydots

Omarchy machine config, tracked the Omarchy way: plain files layered over stock
Omarchy, **not** managed by Nix (this folder just lives in the nix-config repo
so all machine config is in one place).

Omarchy owns the base system (`/usr/share/omarchy`, evolved by `omarchy update`
migrations). This folder tracks only the user delta plus the small `/etc` layer
that git can't express through home configs alone.

## Layout

- `manifest` — home-relative paths that are tracked (globs allowed)
- `home/` — snapshot of those files (mirrors `$HOME`)
- `etc/systemd/system/` — keyd auto-reload units
- `sync.sh` — copy live machine state into the repo (run after config changes)
- `bootstrap.sh` — reproduce everything on a fresh Omarchy install

## Workflow

- Changed a config (or an Omarchy migration did)? `./sync.sh`, review
  `git diff`, commit.
- New file worth tracking? Add a line to `manifest`, run `./sync.sh`.
- New machine: install Omarchy, clone this repo, run `./bootstrap.sh`.

## What the keyd setup is

CapsLock: tap = Escape, hold + hjkl = arrows (`overload(nav, esc)`).
Real config in `~/.config/keyd/default.conf`, symlinked from
`/etc/keyd/default.conf`; a systemd path unit runs `keyd reload` on save, and
the Omarchy menu entry (Setup → Keyd) comes from
`.config/omarchy/extensions/omarchy-menu.jsonc`.
