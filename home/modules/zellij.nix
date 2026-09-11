# Zellij multiplexer. Its default green status/keybind bar is replaced by a
# single clean zjstatus bar (mode + tabs on the left, clock on the right),
# themed to Catppuccin Mocha to match the rest of the setup. zjstatus ships as
# an architecture-independent wasm plugin, fetched directly (no rust build) so
# the same file works on every host. The theme itself (catppuccin-mocha) is set
# by the catppuccin home-manager module via theme.nix.
{
  lib,
  pkgs,
  isDarwin,
  isServer,
  ...
}: let
  zjstatus = pkgs.fetchurl {
    url = "https://github.com/dj95/zjstatus/releases/download/v0.23.0/zjstatus.wasm";
    hash = "sha256-4AaQEiNSQjnbYYAh5MxdF/gtxL+uVDKJW6QfA/E4Yf8=";
  };
in {
  programs.zellij = {
    enable = true;
    settings =
      {
        show_startup_tips = false;
        pane_frames = false;

        # Forward the enhanced (kitty) keyboard protocol to the running pane.
        # WezTerm speaks it natively; without this zellij collapses modified keys
        # like Shift+Enter down to plain Enter, so TUIs inside zellij (e.g. Claude
        # Code's newline-on-Shift+Enter) never see the modifier. Default is false.
        support_kitty_keyboard_protocol = true;

        keybinds = {
          normal = {
            # Free Ctrl+g for the foreground app. Zellij binds it (via
            # shared_except "locked") to enter Locked mode, which swallows it
            # before the running TUI sees it — this is why Ctrl+g (Claude Code's
            # "edit prompt in $EDITOR") did nothing inside zellij. Unbinding it
            # lets it pass through while typing; Locked mode moves to Alt+g below.
            "unbind \"Ctrl g\"" = {};
            "bind \"Alt g\"" = {
              SwitchToMode = "Locked";
            };
            "bind \"Alt q\"" = {
              CloseFocus = {};
            };
            "bind \"Alt t\"" = {
              NewTab = {};
            };
          };
          # Lock mode toggles on Alt+g (not Ctrl+g) so that Ctrl+g passes through
          # to the app even while locked — locking to *use* a Ctrl+g app would be
          # self-defeating otherwise.
          locked = {
            "unbind \"Ctrl g\"" = {};
            "bind \"Alt g\"" = {
              SwitchToMode = "Normal";
            };
          };
        };
      }
      # Copy selections by shelling out to the OS clipboard tool. The default
      # mechanism (an OSC 52 escape sequence relayed through the terminal) fails
      # silently in some terminal/mux combinations, leaving mouse-selection copy
      # broken. The server keeps the OSC 52 default: it has no local clipboard,
      # and OSC 52 is the only thing that reaches the local one over SSH.
      // lib.optionalAttrs (!isServer) {
        copy_command =
          if isDarwin
          then "pbcopy"
          else "clip.exe"; # WSL: Windows clipboard
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

  # Auto-start is server-only: attach-or-create a single named session so a
  # dropped SSH connection reconnects to the same running session (the whole
  # point of a multiplexer on a headless box). Locally zellij is started by
  # hand — `zj` for a throwaway session, `zjc` to attach-or-create the named
  # one (aliases in shell.nix). Guards:
  #   - interactive only.
  #   - not already inside zellij ($ZELLIJ set) -> never nests.
  #   - $ZELLIJ_NO_AUTO lets a shell opt out (escape hatch for maintenance).
  #   - skip VS Code's integrated terminal (Remote-SSH), which manages its own
  #     panes.
  programs.fish.interactiveShellInit = lib.mkIf isServer ''
    if status is-interactive
        and not set -q ZELLIJ
        and not set -q ZELLIJ_NO_AUTO
        and test "$TERM_PROGRAM" != vscode
        zellij attach -c main
    end
  '';

  # zsh is only the fallback shell, but keep the default consistent there too.
  programs.zsh.initExtra = lib.mkIf isServer ''
    if [[ -o interactive && -z "$ZELLIJ" && -z "$ZELLIJ_NO_AUTO" && "$TERM_PROGRAM" != "vscode" ]]; then
      zellij attach -c main
    fi
  '';
}
