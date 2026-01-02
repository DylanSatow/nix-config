{ config, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = false;  # helix is already set as default
    viAlias = true;
    vimAlias = true;
  };

  # Symlink the nvim config directory to ~/.config/nvim
  xdg.configFile.nvim = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/home/nix-config/home/nvim";
    recursive = true;
  };
}
