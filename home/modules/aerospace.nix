# AeroSpace tiling window manager. Installed externally (Homebrew cask) —
# home-manager only links the config it reads at ~/.config/aerospace/aerospace.toml.
# All bindings hang off a single Mod chord (Ctrl+Alt+Cmd, produced by holding
# Caps Lock via karabiner.nix, or a dedicated Moonlander key) with Shift as the
# "move" variant — i3's mod/mod+shift grammar. Alt stays entirely free for
# zellij, which owns it inside the terminal.
{...}: let
  # The whole scheme retunes from these two lines.
  mod = "ctrl-alt-cmd";
  modShift = "ctrl-alt-cmd-shift";
in {
  xdg.configFile."aerospace/aerospace.toml".text = ''
    config-version = 2

    start-at-login = true
    auto-reload-config = true

    # Normalizations keep the layout tree sane (no nested same-orientation
    # containers, no single-child wrappers).
    enable-normalization-flatten-containers = true
    enable-normalization-opposite-orientation-for-nested-containers = true

    accordion-padding = 30
    default-root-container-layout = 'tiles'
    default-root-container-orientation = 'auto'

    # Mouse follows focus when the focused monitor changes.
    on-focused-monitor-changed = ['move-mouse monitor-lazy-center']

    [mode.main.binding]
        ${mod}-h = 'focus left'
        ${mod}-j = 'focus down'
        ${mod}-k = 'focus up'
        ${mod}-l = 'focus right'

        ${modShift}-h = 'move left'
        ${modShift}-j = 'move down'
        ${modShift}-k = 'move up'
        ${modShift}-l = 'move right'

        ${mod}-1 = 'workspace 1'
        ${mod}-2 = 'workspace 2'
        ${mod}-3 = 'workspace 3'
        ${mod}-4 = 'workspace 4'
        ${mod}-5 = 'workspace 5'
        ${mod}-6 = 'workspace 6'
        ${mod}-7 = 'workspace 7'
        ${mod}-8 = 'workspace 8'
        ${mod}-9 = 'workspace 9'

        ${modShift}-1 = 'move-node-to-workspace 1'
        ${modShift}-2 = 'move-node-to-workspace 2'
        ${modShift}-3 = 'move-node-to-workspace 3'
        ${modShift}-4 = 'move-node-to-workspace 4'
        ${modShift}-5 = 'move-node-to-workspace 5'
        ${modShift}-6 = 'move-node-to-workspace 6'
        ${modShift}-7 = 'move-node-to-workspace 7'
        ${modShift}-8 = 'move-node-to-workspace 8'
        ${modShift}-9 = 'move-node-to-workspace 9'

        ${mod}-tab = 'workspace-back-and-forth'

        ${mod}-f = 'fullscreen'
        ${mod}-t = 'layout tiles horizontal vertical'
        ${mod}-a = 'layout accordion horizontal vertical'
        ${mod}-v = 'layout floating tiling'
        ${mod}-q = 'close'

        # App launchers — `open -a` focuses the app if it's already running.
        ${mod}-enter = 'exec-and-forget open -a WezTerm'
        ${modShift}-enter = 'exec-and-forget open -a Safari'
        ${mod}-m = 'exec-and-forget open -a Spotify'
        ${mod}-s = 'exec-and-forget open -a Slack'
        ${mod}-i = 'exec-and-forget open -a Firefox'

        ${modShift}-c = 'reload-config'
        ${mod}-r = 'mode resize'

    [mode.resize.binding]
        h = 'resize width -50'
        j = 'resize height +50'
        k = 'resize height -50'
        l = 'resize width +50'
        minus = 'resize smart -50'
        equal = 'resize smart +50'
        enter = 'mode main'
        esc = 'mode main'
  '';
}
