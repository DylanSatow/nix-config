# wezterm is installed externally (Homebrew cask on mac, manually on WSL) —
# home-manager only links the config it reads at ~/.config/wezterm/wezterm.lua.
# Catppuccin Mocha via wezterm's built-in scheme. The fancy tab bar (default)
# gives natural, padded tabs; window_frame sets its font. Frosted-glass look is
# a translucent window over a blurred desktop (blur + integrated buttons mac-only).
{
  pkgs,
  lib,
  isDarwin,
  isWsl,
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

    -- Enable the enhanced (kitty) keyboard protocol; disabled by default in
    -- wezterm. Without it, modified keys like Shift+Enter collapse to plain
    -- Enter, so Claude Code's newline-on-Shift+Enter never sees the modifier
    -- (zellij's support_kitty_keyboard_protocol then has nothing to forward).
    config.enable_kitty_keyboard = true

    -- Launch the fish configured by home-manager.
    config.default_prog = {'${pkgs.fish}/bin/fish', '-l'}

    -- No tab bar: zellij handles tabs/splits, so wezterm's is redundant.
    config.enable_tab_bar = false

    -- Dim inactive split panes.
    config.inactive_pane_hsb = {saturation = 0.0, brightness = 0.5}

    -- Bare-shell window: opens fish with $ZELLIJ_NO_AUTO set so it skips the
    -- zellij auto-start. Use it to ssh into a host that runs its own zellij —
    -- the remote session is then the only layer (no local-wraps-remote nesting).
    config.keys = {
      {
        key = 'n',
        mods = '${
      if isDarwin
      then "CMD|SHIFT"
      else "CTRL|SHIFT"
    }',
        action = wezterm.action.SpawnCommandInNewWindow {
          set_environment_variables = { ZELLIJ_NO_AUTO = '1' },
        },
      },
      -- Work around a wezterm bug: with enable_kitty_keyboard on, the forward
      -- delete key (fn+delete on mac) is sent as ^H, which zellij reads as its
      -- Ctrl+h "move mode" bind instead of Del (e.g. delete-session in the
      -- session manager). Send the correct escape sequence explicitly.
      -- https://github.com/wezterm/wezterm/issues/4785
      {
        key = 'Delete',
        mods = 'NONE',
        action = wezterm.action.SendString '\x1b[3~',
      },
    }

    -- Fully opaque window.
    config.window_background_opacity = 1.0
  '';

  darwin = lib.optionalString isDarwin ''
    config.macos_window_background_blur = 50
    config.send_composed_key_when_left_alt_is_pressed = false

    -- No title bar or buttons either — fully barless window. RESIZE keeps it
    -- draggable (by the body) and resizable from the edges.
    config.window_decorations = 'RESIZE'
  '';

  # The native Windows wezterm is pointed at this WSL-side file (via the
  # WEZTERM_CONFIG_FILE Windows env var). Default new tabs/windows into the WSL
  # distro so it behaves like a WSL terminal. Guarded on the Windows target
  # triple so the same file, if ever read by a Linux wezterm under WSLg, skips
  # the (nonexistent) WSL domain rather than erroring.
  wsl = lib.optionalString isWsl ''
    if wezterm.target_triple:find('windows') then
      config.default_domain = 'WSL:Ubuntu'
    end
  '';
in {
  xdg.configFile."wezterm/wezterm.lua".text = base + darwin + wsl + "\nreturn config\n";
}
