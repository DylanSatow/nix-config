# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

let
  colors = import ./colors.nix;
in
with lib.hm.gvariant;

{
  dconf.settings = {
    "org/gnome/calendar" = {
      active-view = "month";
      window-maximized = true;
      window-size = mkTuple [
        768
        600
      ];
    };

    "org/gnome/control-center" = {
      last-panel = "background";
      window-state = mkTuple [
        980
        640
        false
      ];
    };

    "org/gnome/desktop/app-folders" = {
      folder-children = [
        "System"
        "Utilities"
        "YaST"
        "Pardus"
      ];
    };

    "org/gnome/desktop/app-folders/folders/Pardus" = {
      categories = [ "X-Pardus-Apps" ];
      name = "X-Pardus-Apps.directory";
      translate = true;
    };

    "org/gnome/desktop/app-folders/folders/System" = {
      apps = [
        "nm-connection-editor.desktop"
        "org.gnome.baobab.desktop"
        "org.gnome.DiskUtility.desktop"
        "org.gnome.Logs.desktop"
        "org.gnome.tweaks.desktop"
        "org.gnome.SystemMonitor.desktop"
      ];
      name = "X-GNOME-Shell-System.directory";
      translate = true;
    };

    "org/gnome/desktop/app-folders/folders/Utilities" = {
      apps = [
        "org.gnome.Connections.desktop"
        "org.gnome.Evince.desktop"
        "org.gnome.FileRoller.desktop"
        "org.gnome.font-viewer.desktop"
        "org.gnome.Loupe.desktop"
        "org.gnome.seahorse.Application.desktop"
      ];
      name = "X-GNOME-Shell-Utilities.directory";
      translate = true;
    };

    "org/gnome/desktop/app-folders/folders/YaST" = {
      categories = [ "X-SuSE-YaST" ];
      name = "suse-yast.directory";
      translate = true;
    };

    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///home/dylan/.local/share/backgrounds/space.jpg";
      picture-uri-dark = "file:///home/dylan/.local/share/backgrounds/space.jpg";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };

    "org/gnome/desktop/break-reminders/eyesight" = {
      play-sound = true;
    };

    "org/gnome/desktop/break-reminders/movement" = {
      duration-seconds = mkUint32 300;
      interval-seconds = mkUint32 1800;
      play-sound = true;
    };

    "org/gnome/desktop/input-sources" = {
      sources = [
        (mkTuple [
          "xkb"
          "us"
        ])
      ];
      xkb-options = [
        "terminate:ctrl_alt_bksp"
        "caps:escape"
      ];
    };

    "org/gnome/desktop/interface" = {
      accent-color = colors.accentColor;
      color-scheme = "prefer-dark";
      gtk-theme = colors.themeName;
      icon-theme = "Papirus-Dark";
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/screensaver" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///home/dylan/.local/share/backgrounds/space.jpg";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };

    "org/gnome/desktop/search-providers" = {
      sort-order = [
        "org.gnome.Settings.desktop"
        "org.gnome.Contacts.desktop"
        "org.gnome.Nautilus.desktop"
      ];
    };

    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>q" ];
      maximize = [ "<Super>f" ];
      minimize = [ ];
      move-to-workspace-1 = [ "<Shift><Super>1" ];
      move-to-workspace-2 = [ "<Shift><Super>2" ];
      move-to-workspace-3 = [ "<Shift><Super>3" ];
      move-to-workspace-4 = [ "<Shift><Super>4" ];
      move-to-workspace-left = [ "<Shift><Super>h" ];
      move-to-workspace-right = [ "<Shift><Super>l" ];
      switch-to-workspace-1 = [ "<Super>1" ];
      switch-to-workspace-2 = [ "<Super>2" ];
      switch-to-workspace-3 = [ "<Super>3" ];
      switch-to-workspace-4 = [ "<Super>4" ];
      switch-to-workspace-left = [ "<Super>h" ];
      switch-to-workspace-right = [ "<Super>l" ];
    };

    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 5;
    };

    "org/gnome/evolution-data-server" = {
      migrated = true;
    };

    "org/gnome/mutter" = {
      dynamic-workspaces = false;
    };

    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "icon-view";
      migrated-gtk-settings = true;
      search-filter-time-type = "last_modified";
    };

    "org/gnome/nautilus/window-state" = {
      initial-size = mkTuple [
        890
        550
      ];
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-schedule-automatic = false;
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
      ];
      screensaver = [ ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "kitty";
      name = "Kitty";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>b";
      command = "firefox";
      name = "Firefox";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      binding = "<Super>v";
      command = "code";
      name = "Vscode";
    };

    "org/gnome/shell" = {
      welcome-dialog-last-shown-version = "48.2";
    };

    # Dash to Dock — floating Catppuccin Mocha dock
    "org/gnome/shell/extensions/dash-to-dock" = {
      dock-position = "BOTTOM";
      dock-fixed = false;
      autohide = true;
      intellihide = true;
      height-fraction = 0.9;
      dash-max-icon-size = 48;
      custom-background-color = true;
      background-color = colors.base;
      background-opacity = 0.75;
      transparency-mode = "FIXED";
      custom-theme-shrink = true;
      show-trash = false;
      show-mounts = false;
      click-action = "minimize-or-previews";
      scroll-action = "cycle-windows";
      apply-custom-theme = false;
      running-indicator-style = "DOTS";
      running-indicator-dominant-color = true;
    };

    # Arc Menu — Catppuccin Mocha styled spotlight search
    "org/gnome/shell/extensions/arcmenu" = {
      menu-layout = "Runner";
      runner-position = "Centered";
      runner-menu-width = 600;
      runner-menu-height = 400;
      runner-search-display-style = "List";
      runner-show-frequent-apps = true;
      # Custom Catppuccin Mocha colors
      override-menu-theme = true;
      menu-background-color = colors.base;
      menu-foreground-color = colors.text;
      menu-border-color = colors.surface1;
      menu-border-width = 1;
      menu-border-radius = 14;
      menu-font-size = 11;
      menu-separator-color = "rgba(69,71,90,0.6)";
      menu-item-hover-bg-color = colors.surface0;
      menu-item-hover-fg-color = colors.lavender;
      menu-item-active-bg-color = colors.surface1;
      menu-item-active-fg-color = colors.lavender;
      search-entry-border-radius = mkTuple [true 25];
    };

    # Space Bar — workspace indicator in the top bar
    "org/gnome/shell/extensions/space-bar/behavior" = {
      show-empty-workspaces = true;
      scroll-wheel = "panel";
      smart-workspace-names = false;
      toggle-overview = false;
    };

    "org/gnome/shell/extensions/space-bar/appearance" = {
      workspaces-bar-padding = 8;
      workspace-margin = 4;
      # Active workspace — lavender pill
      active-workspace-background-color = colors.lavender;
      active-workspace-text-color = colors.crust;
      active-workspace-border-color = "rgba(0,0,0,0)";
      active-workspace-border-radius = 4;
      active-workspace-font-weight = "700";
      active-workspace-padding-h = 8;
      active-workspace-padding-v = 3;
      # Inactive workspaces — subtle text
      inactive-workspace-background-color = "rgba(0,0,0,0)";
      inactive-workspace-text-color = colors.subtext0;
      inactive-workspace-border-color = "rgba(0,0,0,0)";
      # Empty workspaces — dimmed
      empty-workspace-background-color = "rgba(0,0,0,0)";
      empty-workspace-text-color = colors.surface1;
      empty-workspace-border-color = "rgba(0,0,0,0)";
    };

    "org/gnome/shell/app-switcher" = {
      current-workspace-only = true;
    };

    # Blur my Shell — blur effects across the desktop
    "org/gnome/shell/extensions/blur-my-shell" = {
      sigma = 30;
      brightness = 0.6;
      color-and-noise = true;
      noise-amount = 0.0;
      hacks-level = 1;
    };

    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      blur = true;
      override-background = true;
      style-panel = 0;
      static-blur = true;
      unblur-in-overview = true;
    };

    "org/gnome/shell/extensions/blur-my-shell/overview" = {
      blur = true;
      style-components = 1;
    };

    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
      blur = true;
      override-background = true;
      static-blur = true;
      style-dash-to-dock = 0;
      unblur-in-overview = false;
    };

    "org/gnome/shell/extensions/blur-my-shell/appfolder" = {
      blur = true;
    };

    "org/gnome/shell/extensions/blur-my-shell/lockscreen" = {
      blur = true;
    };

    "org/gnome/shell/extensions/blur-my-shell/screenshot" = {
      blur = true;
    };

    # Vitals — system stats in the top bar
    "org/gnome/shell/extensions/vitals" = {
      position-in-panel = 2; # right side
      update-time = 3;
      hot-sensors = [
        "_processor_usage_"
        "_memory_usage_"
        "_temperature_gpu_"
      ];
      show-processor = true;
      show-memory = true;
      show-temperature = true;
      show-gpu = true;
      show-network = false;
      show-fan = false;
      show-voltage = false;
      show-storage = false;
      show-system = false;
      show-battery = false;
      include-public-ip = false;
      fixed-widths = true;
      hide-icons = false;
      use-higher-precision = false;
    };

    "org/gnome/shell/keybindings" = {
      switch-to-application-1 = [ ];
      switch-to-application-2 = [ ];
      switch-to-application-3 = [ ];
      switch-to-application-4 = [ ];
      toggle-message-tray = [ ];
    };

    "org/gnome/shell/world-clocks" = {
      locations = [ ];
    };

  };
}
