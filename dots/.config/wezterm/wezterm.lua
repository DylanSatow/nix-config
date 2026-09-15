-- Portable twin of home/modules/wezterm.nix (mac branch). Keep in sync.
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

-- Launch fish as a login shell. GUI-launched wezterm has a minimal PATH, so
-- probe the usual install locations; fall back to wezterm's default shell.
local function first_existing(paths)
  for _, p in ipairs(paths) do
    local f = io.open(p, 'r')
    if f then f:close(); return p end
  end
end
local fish = first_existing {
  '/opt/homebrew/bin/fish', '/usr/local/bin/fish', '/usr/bin/fish', '/home/linuxbrew/.linuxbrew/bin/fish',
}
if fish then config.default_prog = { fish, '-l' } end

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
    mods = 'CMD|SHIFT',
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
  -- Work around herdr swallowing a tapped Escape under the kitty keyboard
  -- protocol: herdr forwards the key-press report but chokes on the
  -- key-release report that follows a quick tap, so the Escape never
  -- reaches the pane (holding the key delays the release, which is why
  -- that works). Only when herdr is the foreground process, send the
  -- press-only kitty encoding directly; everywhere else behave normally so
  -- Shift+Enter in Claude Code keeps working.
  -- https://github.com/herdrdev/herdr/issues/1266
  {
    key = 'Escape',
    mods = 'NONE',
    action = wezterm.action_callback(function(window, pane)
      local process = pane:get_foreground_process_name() or ""
      if process:match('/herdr$') then
        pane:send_text('\x1b[27;1u')
      else
        window:perform_action(wezterm.action.SendKey { key = 'Escape', mods = 'NONE' }, pane)
      end
    end),
  },
}

-- Fully opaque window.
config.window_background_opacity = 1.0
config.macos_window_background_blur = 50
config.send_composed_key_when_left_alt_is_pressed = false

-- No title bar or buttons either — fully barless window. RESIZE keeps it
-- draggable (by the body) and resizable from the edges.
config.window_decorations = 'RESIZE'

return config
