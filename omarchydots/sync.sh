#!/bin/bash
# Pull the live Omarchy config delta from this machine into the repo.
# Run after changing any tracked config, then review with git diff.
set -euo pipefail
cd "$(dirname "$0")"

while read -r line; do
  [[ -z $line || $line == \#* ]] && continue
  for src in "$HOME"/$line; do
    [[ -f $src ]] || continue
    rel="${src#"$HOME"/}"
    install -Dm644 "$src" "home/$rel"
  done
done <manifest

for unit in /etc/systemd/system/keyd-reload.path /etc/systemd/system/keyd-reload.service; do
  [[ -f $unit ]] && install -Dm644 "$unit" "etc${unit#/etc}"
done

git status --short -- .
