{ pkgs, ... }: {
  # Configure skhd (Simple Hotkey Daemon) for global keyboard shortcuts
  services.skhd = {
    enable = true;
    skhdConfig = ''
      # Alt + n: Open neovide with nix-config directory as working directory
      alt - n : /bin/bash -c 'cd "/Users/dylan/home/nix-config" && /run/current-system/sw/bin/neovide --cmd "cd /Users/dylan/home/nix-config" .'
    '';
  };
}