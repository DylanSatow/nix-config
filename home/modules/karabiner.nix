# Karabiner-Elements key remapping. Installed externally (Homebrew cask) —
# home-manager only links the config it reads at ~/.config/karabiner/karabiner.json.
# Two rules:
#  1. Caps Lock held is Ctrl+Alt+Cmd (the AeroSpace Mod chord — see
#     aerospace.nix), tapped alone it's Escape. `optional: any` lets Shift stack
#     on top for the Mod+Shift "move" variants.
#  2. Tab held is a navigation layer: h/j/k/l become the arrow keys. Tapped alone
#     it's a normal Tab. The Tab rule deliberately matches *no* modifiers so
#     Cmd+Tab / Shift+Tab / Ctrl+Tab pass through untouched; the hjkl rules accept
#     any modifier so Shift-select and Option-word-jump work inside the layer.
#     Tab (not a letter) is the layer key because Karabiner has no permissive-hold
#     logic: a letter would misfire on fast rolls like "exh".
#
# Trade-off of linking the file read-only from the nix store: the Karabiner UI
# cannot save changes, so all config edits go through this module. Karabiner's
# daemon also rewrites the file on launch/UI interaction, replacing the symlink
# with a plain file — `force = true` reclaims it on every switch.
{lib, ...}: let
  navLayer = "nav_layer";
  navKeys = {
    h = "left_arrow";
    j = "down_arrow";
    k = "up_arrow";
    l = "right_arrow";
  };
in {
  xdg.configFile."karabiner/karabiner.json" = {
    force = true;
    text = builtins.toJSON {
      global.show_in_menu_bar = false;
      profiles = [
        {
          name = "Default";
          selected = true;
          virtual_hid_keyboard.keyboard_type_v2 = "ansi";
          complex_modifications.rules = [
            {
              description = "Caps Lock -> Ctrl+Alt+Cmd (hold) / Escape (tap)";
              manipulators = [
                {
                  type = "basic";
                  from = {
                    key_code = "caps_lock";
                    modifiers.optional = ["any"];
                  };
                  to = [
                    {
                      key_code = "left_control";
                      modifiers = ["left_option" "left_command"];
                    }
                  ];
                  to_if_alone = [{key_code = "escape";}];
                }
              ];
            }
            {
              description = "Tab (hold) -> navigation layer: hjkl = arrows / Tab (tap)";
              manipulators =
                [
                  {
                    type = "basic";
                    from.key_code = "tab";
                    to = [
                      {
                        set_variable = {
                          name = navLayer;
                          value = 1;
                        };
                      }
                    ];
                    to_if_alone = [{key_code = "tab";}];
                    to_after_key_up = [
                      {
                        set_variable = {
                          name = navLayer;
                          value = 0;
                        };
                      }
                    ];
                  }
                ]
                ++ lib.mapAttrsToList (key: arrow: {
                  type = "basic";
                  from = {
                    key_code = key;
                    modifiers.optional = ["any"];
                  };
                  to = [{key_code = arrow;}];
                  conditions = [
                    {
                      type = "variable_if";
                      name = navLayer;
                      value = 1;
                    }
                  ];
                })
                navKeys;
            }
          ];
        }
      ];
    };
  };
}
