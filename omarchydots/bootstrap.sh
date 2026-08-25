#!/bin/bash
# Reproduce this machine's Omarchy customizations on a fresh Omarchy install.
# Idempotent: safe to re-run. Prompts for sudo for the /etc layer.
set -euo pipefail
cd "$(dirname "$0")"

# --- packages ---------------------------------------------------------------
omarchy pkg add keyd

# --- home config delta ------------------------------------------------------
while read -r line; do
  [[ -z $line || $line == \#* ]] && continue
  for src in home/$line; do
    [[ -f $src ]] || continue
    install -Dm644 "$src" "$HOME/${src#home/}"
  done
done <manifest

# --- system layer: keyd config symlink + auto-reload units ------------------
sudo ln -sf "$HOME/.config/keyd/default.conf" /etc/keyd/default.conf
sudo install -Dm644 etc/systemd/system/keyd-reload.service /etc/systemd/system/keyd-reload.service
sudo install -Dm644 etc/systemd/system/keyd-reload.path /etc/systemd/system/keyd-reload.path
sudo systemctl daemon-reload
sudo systemctl enable --now keyd keyd-reload.path
sudo usermod -aG keyd "$USER"
sudo keyd reload

echo "Done. Log out/in for keyd group membership; reload Hyprland with: hyprctl reload"
