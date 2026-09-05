# Karabiner-Elements key remapping. Installed externally (Homebrew cask) —
# home-manager only links the config it reads at ~/.config/karabiner/karabiner.json.
# One rule: Caps Lock held is Ctrl+Alt+Cmd (the AeroSpace Mod chord — see
# aerospace.nix), tapped alone it's Escape. `optional: any` lets Shift stack on
# top for the Mod+Shift "move" variants.
#
# Trade-off of linking the file read-only from the nix store: the Karabiner UI
# cannot save changes, so all config edits go through this module. Karabiner's
# daemon also rewrites the file on launch/UI interaction, replacing the symlink
# with a plain file — `force = true` reclaims it on every switch.
{...}: {
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
          ];
        }
      ];
    };
  };
}
