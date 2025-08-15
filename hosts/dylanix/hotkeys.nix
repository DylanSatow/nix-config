{ pkgs, ... }: {
  services.skhd = {
    enable = true;
    skhdConfig = ''
      alt - n : /bin/bash -c 'cd "/Users/dylan/home/nix-config" && /run/current-system/sw/bin/neovide --cmd "cd /Users/dylan/home/nix-config" .'
    '';
  };
}