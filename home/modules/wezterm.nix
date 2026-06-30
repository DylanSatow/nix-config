# wezterm is installed externally (Homebrew cask on mac, manually on WSL) —
# home-manager only links the config it reads at ~/.config/wezterm/wezterm.lua.
# Catppuccin Mocha via wezterm's built-in scheme. The frosted-glass look is a
# translucent window over a blurred desktop background (blur is macOS-only).
{
  pkgs,
  lib,
  isDarwin,
  ...
}: let
  base = ''
    local wezterm = require 'wezterm'
    local config = wezterm.config_builder()

    config.font = wezterm.font 'JetBrainsMono Nerd Font'
    config.font_size = 20.0
    config.color_scheme = 'Catppuccin Mocha'
    config.default_cursor_style = 'SteadyBar'

    -- Launch the fish configured by home-manager.
    config.default_prog = {'${pkgs.fish}/bin/fish', '-l'}

    -- Frosted glass: hide chrome, let the blurred wallpaper show through.
    config.enable_tab_bar = false
    config.window_background_opacity = 0.85
  '';

  darwin = lib.optionalString isDarwin ''
    config.macos_window_background_blur = 30
    config.send_composed_key_when_left_alt_is_pressed = false
  '';
in {
  xdg.configFile."wezterm/wezterm.lua".text = base + darwin + "\nreturn config\n";
}
