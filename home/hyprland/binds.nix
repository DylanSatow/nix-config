{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland.settings = {
    bind = [
      # Applications
      "$mod, Return, exec, $terminal"
      "$mod, E, exec, $fileManager"
      "$mod, R, exec, $menu"
      "$mod, B, exec, $browser"
      "$mod, O, exec, $life" # Open Obsidian/Emacs/whatever I use for managing my life down the line 
      "$mod, C, exec, $code"


      "$mod, Q, killactive"
      "$mod SHIFT, M, exit"
      "$mod, V, togglefloating"
      "$mod, P, pseudo"
      "$mod, J, togglesplit"
      "$mod, F, fullscreen"

      # Wallpapers
      "$mod, W, exec, swww img $(find ~/home/nix-config/home/wallpapers -type f | shuf -n 1)"

      # Move focus with vim-like keys
      "$mod, H, movefocus, l"
      "$mod, L, movefocus, r"
      "$mod, K, movefocus, u"
      "$mod, J, movefocus, d"

      # Move windows with vim-like keys
      "$mod SHIFT, H, movewindow, l"
      "$mod SHIFT, L, movewindow, r"
      "$mod SHIFT, K, movewindow, u"
      "$mod SHIFT, J, movewindow, d"

      # Resize windows with vim-like keys
      "$mod CTRL, H, resizeactive, -20 0"
      "$mod CTRL, L, resizeactive, 20 0"
      "$mod CTRL, K, resizeactive, 0 -20"
      "$mod CTRL, J, resizeactive, 0 20"

      # Switch workspaces
      "$mod, 1, workspace, 1"
      "$mod, 2, workspace, 2"
      "$mod, 3, workspace, 3"
      "$mod, 4, workspace, 4"
      "$mod, 5, workspace, 5"
      "$mod, 6, workspace, 6"
      "$mod, 7, workspace, 7"
      "$mod, 8, workspace, 8"
      "$mod, 9, workspace, 9"
      "$mod, 0, workspace, 10"

      # Move active window to workspace
      "$mod SHIFT, 1, movetoworkspace, 1"
      "$mod SHIFT, 2, movetoworkspace, 2"
      "$mod SHIFT, 3, movetoworkspace, 3"
      "$mod SHIFT, 4, movetoworkspace, 4"
      "$mod SHIFT, 5, movetoworkspace, 5"
      "$mod SHIFT, 6, movetoworkspace, 6"
      "$mod SHIFT, 7, movetoworkspace, 7"
      "$mod SHIFT, 8, movetoworkspace, 8"
      "$mod SHIFT, 9, movetoworkspace, 9"
      "$mod SHIFT, 0, movetoworkspace, 10"

      # Workspace navigation
      "$mod, Tab, workspace, m+1"
      "$mod SHIFT, Tab, workspace, m-1"

      # Special workspace (scratchpad)
      "$mod, S, togglespecialworkspace, magic"
      "$mod SHIFT, S, movetoworkspace, special:magic"

      # Screenshots
      "$mod, Print, exec, grim -g \"$(slurp)\" - | wl-copy"
      "$mod SHIFT, Print, exec, grim - | wl-copy"

      # Audio controls
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

      # Brightness controls
      ", XF86MonBrightnessUp, exec, brightnessctl s 10%+"
      ", XF86MonBrightnessDown, exec, brightnessctl s 10%-"

      # Media controls
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPrev, exec, playerctl previous"

      # Lock screen
      "$mod, BackSpace, exec, hyprlock"
    ];

    
  };
}
