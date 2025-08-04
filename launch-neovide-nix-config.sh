#!/bin/bash

# Launch neovide with nix-config directory
cd "/Users/dylan/home/nix-config"
export NEOVIDE_CWD="/Users/dylan/home/nix-config"

# Debug output
echo "Script started" > /tmp/launch_debug.log
echo "Current directory: $(pwd)" >> /tmp/launch_debug.log
echo "NEOVIDE_CWD: $NEOVIDE_CWD" >> /tmp/launch_debug.log

# Launch neovide
exec /run/current-system/sw/bin/neovide --cmd "cd /Users/dylan/home/nix-config" .