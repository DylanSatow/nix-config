#!/usr/bin/env bash
# Symlink every file under dots/ into $HOME, mirroring the directory layout.
# Existing files/links are moved aside as <name>.bak. Re-runnable.
set -euo pipefail
DOTS="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

find "$DOTS" -type f \
  ! -name install.sh ! -name README.md ! -path '*/.git/*' \
  ! -path "$DOTS/Library/*" \
  -print0 | while IFS= read -r -d '' src; do
  rel="${src#"$DOTS"/}"
  dst="$HOME/$rel"
  mkdir -p "$(dirname "$dst")"
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then continue; fi
  if [ -e "$dst" ] || [ -L "$dst" ]; then mv "$dst" "$dst.bak"; echo "backup: $dst -> $dst.bak"; fi
  ln -s "$src" "$dst"
  echo "link:   $dst"
done

# macOS-only paths (VS Code lives under ~/Library, not ~/.config).
if [ "$(uname)" = "Darwin" ]; then
  find "$DOTS/Library" -type f -print0 | while IFS= read -r -d '' src; do
    rel="${src#"$DOTS"/}"
    dst="$HOME/$rel"
    mkdir -p "$(dirname "$dst")"
    if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then continue; fi
    if [ -e "$dst" ] || [ -L "$dst" ]; then mv "$dst" "$dst.bak"; echo "backup: $dst -> $dst.bak"; fi
    ln -s "$src" "$dst"
    echo "link:   $dst"
  done
fi
