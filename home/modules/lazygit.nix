# Lazygit — TUI git client. Owned here (not packages.nix) so home-manager manages
# both the binary and ~/.config/lazygit/config.yml. catppuccin.nix themes it
# automatically via the global catppuccin.enable in theme.nix, so lazygit matches
# the rest of the terminal.
#
# The in-editor lazygit (snacks.nvim, LazyVim's <leader>gg) is configured with
# `configure = false` (see nvim/lua/plugins/lazygit.lua) so it uses THIS config
# instead of generating its own theme from nvim highlights — that generated theme
# rendered dark/off inside neovim. editPreset = "nvim-remote" lets lazygit open
# files back in the parent nvim (via $NVIM) when launched from the editor.
{pkgs, ...}: {
  programs.lazygit = {
    enable = true;
    package = pkgs.unstable.lazygit;
    settings = {
      gui.nerdFontsVersion = "3";
      os.editPreset = "nvim-remote";
    };
  };
}
