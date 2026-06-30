# wezterm is installed externally (Homebrew cask on mac, manually on WSL) —
# home-manager only links the config it reads at ~/.config/wezterm/wezterm.lua.
# Catppuccin Mocha via wezterm's built-in scheme. The fancy tab bar (default)
# gives natural, padded tabs; window_frame sets its font. Frosted-glass look is
# a translucent window over a blurred desktop (blur + integrated buttons mac-only).
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
    config.max_fps = 120

    -- Launch the fish configured by home-manager.
    config.default_prog = {'${pkgs.fish}/bin/fish', '-l'}

    -- No tab bar: zellij handles tabs/splits, so wezterm's is redundant.
    config.enable_tab_bar = false

    -- Dim inactive split panes.
    config.inactive_pane_hsb = {saturation = 0.0, brightness = 0.5}

    -- Frosted glass: translucent window over the blurred wallpaper.
    config.window_background_opacity = 0.8
  '';

  darwin = lib.optionalString isDarwin ''
    config.macos_window_background_blur = 50
    config.send_composed_key_when_left_alt_is_pressed = false

    -- No title bar or buttons either — fully barless window. RESIZE keeps it
    -- draggable (by the body) and resizable from the edges.
    config.window_decorations = 'RESIZE'
  '';
in {
  xdg.configFile."wezterm/wezterm.lua".text = base + darwin + "\nreturn config\n";
}
