# Zellij multiplexer. Its default green status/keybind bar is replaced by a
# single clean zjstatus bar (mode + tabs on the left, clock on the right),
# themed to Catppuccin Mocha to match the rest of the setup. zjstatus ships as
# an architecture-independent wasm plugin, fetched directly (no rust build) so
# the same file works on every host. The theme itself (catppuccin-mocha) is set
# by the catppuccin home-manager module via theme.nix.
{pkgs, ...}: let
  zjstatus = pkgs.fetchurl {
    url = "https://github.com/dj95/zjstatus/releases/download/v0.23.0/zjstatus.wasm";
    hash = "sha256-4AaQEiNSQjnbYYAh5MxdF/gtxL+uVDKJW6QfA/E4Yf8=";
  };
in {
  programs.zellij = {
    enable = true;
    settings = {
      show_startup_tips = false;
      pane_frames = false;
      keybinds = {
        normal = {
          "bind \"Alt q\"" = {
            CloseFocus = {};
          };
          "bind \"Alt t\"" = {
            NewTab = {};
          };
        };
      };
    };
  };

  # Custom default layout: a single borderless zjstatus bar at the top replaces
  # zellij's stock tab-bar + status-bar plugins. Colors are Catppuccin Mocha
  # hex values (lavender #b4befe accent, overlay0 #6c7086 for inactive).
  xdg.configFile."zellij/layouts/default.kdl".text = ''
    layout {
        default_tab_template {
            pane size=1 borderless=true {
                plugin location="file:${zjstatus}" {
                    format_left  "{mode} {tabs}"
                    format_right "{datetime}"
                    format_space ""

                    border_enabled "false"

                    mode_normal          "#[bg=#b4befe,fg=#1e1e2e,bold] NORMAL "
                    mode_locked          "#[bg=#f38ba8,fg=#1e1e2e,bold] LOCKED "
                    mode_default_to_mode "normal"

                    tab_normal "#[fg=#6c7086] {index} {name} "
                    tab_active "#[fg=#b4befe,bold] {index} {name} "

                    datetime          "#[fg=#9399b2,bold] {format} "
                    datetime_format   "%Y-%m-%d %H:%M"
                    datetime_timezone "America/New_York"
                }
            }
            children
        }
    }
  '';
}
