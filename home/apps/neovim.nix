{ ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = false;  # helix is already set as default
    viAlias = true;
    vimAlias = true;
  };

  # Copy nvim config to ~/.config/nvim
  xdg.configFile."nvim" = {
    source = ./nvim;
    recursive = true;
  };
}
