{ config, lib, ... }: {
    # AeroSpace window manager configuration
    home.file.".aerospace.toml".text = ''
        # AeroSpace TOML configuration file
        # Based on Hyprland keybindings and workflow

        # Basic configuration
        enable-normalization-flatten-containers = true
        enable-normalization-opposite-orientation-for-nested-containers = true
        automatically-unhide-macos-hidden-apps = true
        
        # Tiling preferences
        default-root-container-layout = 'tiles'
        default-root-container-orientation = 'auto'

        # On startup
        after-startup-command = []

        # Exec configuration
        [exec]
            inherit-env-vars = true
        [exec.env-vars]
            PATH = '/opt/homebrew/bin:/opt/homebrew/sbin:''${PATH}'

        # Key mapping
        [key-mapping]
            preset = 'qwerty'

        # Main mode bindings - matching Hyprland workflow
        [mode.main.binding]
            # Applications (matching Hyprland $mod bindings)
            alt-enter = 'exec-and-forget open -a /Applications/kitty.app'
            alt-e = 'exec-and-forget open -a "Finder"'
            alt-b = 'exec-and-forget open -a "Firefox"'
            alt-c = 'exec-and-forget open -a "Neovide"'
            alt-v = 'exec-and-forget open -a "Visual Studio Code"'
            alt-o = 'exec-and-forget open -a "Obsidian"'
            alt-w = 'exec-and-forget open -a "Warp"'

            # Window management
            alt-q = 'close'
            alt-f = 'fullscreen'
            alt-shift-m = 'exec-and-forget osascript -e "tell app \"System Events\" to log out"'

            # Focus movement (vim-like keys matching Hyprland)
            alt-h = 'focus left'
            alt-j = 'focus down'
            alt-k = 'focus up'
            alt-l = 'focus right'

            # Move windows (matching Hyprland shift combinations)
            alt-shift-h = 'move left'
            alt-shift-j = 'move down'
            alt-shift-k = 'move up'
            alt-shift-l = 'move right'

            # Resize windows (matching Hyprland ctrl combinations)
            alt-ctrl-h = 'resize width -50'
            alt-ctrl-l = 'resize width +50'
            alt-ctrl-k = 'resize height -50'
            alt-ctrl-j = 'resize height +50'

            # Layout controls
            alt-r = 'layout tiles horizontal vertical'
            alt-shift-r = 'layout floating tiling'

            # Workspace switching (1-9, 0 for workspace 10)
            alt-1 = 'workspace 1'
            alt-2 = 'workspace 2'
            alt-3 = 'workspace 3'
            alt-4 = 'workspace 4'
            alt-5 = 'workspace 5'
            alt-6 = 'workspace 6'
            alt-7 = 'workspace 7'
            alt-8 = 'workspace 8'
            alt-9 = 'workspace 9'
            alt-0 = 'workspace 10'

            # Move window to workspace with focus following (matching Hyprland shift combinations)
            alt-shift-1 = ['move-node-to-workspace --focus-follows-window 1']
            alt-shift-2 = ['move-node-to-workspace --focus-follows-window 2']
            alt-shift-3 = ['move-node-to-workspace --focus-follows-window 3']
            alt-shift-4 = ['move-node-to-workspace --focus-follows-window 4']
            alt-shift-5 = ['move-node-to-workspace --focus-follows-window 5']
            alt-shift-6 = ['move-node-to-workspace --focus-follows-window 6']
            alt-shift-7 = ['move-node-to-workspace --focus-follows-window 7']
            alt-shift-8 = ['move-node-to-workspace --focus-follows-window 8']
            alt-shift-9 = ['move-node-to-workspace --focus-follows-window 9']
            alt-shift-0 = ['move-node-to-workspace --focus-follows-window 10']

            # Workspace navigation (matching Hyprland tab behavior)
            alt-tab = 'workspace-back-and-forth'

            # Screenshots (using macOS built-in screencapture)
            alt-shift-s = 'exec-and-forget screencapture -i -c'
            alt-shift-f = 'exec-and-forget screencapture -c'

            # Service mode for advanced operations
            alt-semicolon = 'mode service'

        # Service mode for advanced window management
        [mode.service.binding]
            esc = ['reload-config', 'mode main']
            r = ['flatten-workspace-tree', 'mode main']
            backspace = ['close-all-windows-but-current', 'mode main']
            
            # Layout adjustments
            f = ['layout floating tiling', 'mode main']
            h = ['layout h_tiles', 'mode main']
            v = ['layout v_tiles', 'mode main']
            
            # Return to main mode
            alt-semicolon = 'mode main'

        # Application-specific rules (matching common macOS apps)
        [[on-window-detected]]
            if.app-id = 'com.apple.systempreferences'
            run = 'layout floating'

        [[on-window-detected]]
            if.app-id = 'com.apple.calculator'
            run = 'layout floating'

        [[on-window-detected]]
            if.app-id = 'com.apple.ActivityMonitor'
            run = 'layout floating'
    '';
}
