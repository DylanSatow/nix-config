{
  isDarwin,
  isWsl,
  lib,
  ...
}: let
  kittySettings =
    {
      font_family = "JetBrainsMono Nerd Font";
      font_size = 20;
      cursor_shape = "beam";
      cursor_trail = 1;
    }
    // lib.optionalAttrs isDarwin {
      macos_option_as_alt = "yes";
    };
in {
  config = lib.mkMerge [
    {
      programs.alacritty = {
        enable = true;
        settings = {
          font = {
            size = 11;
            normal = {
              family = "JetBrains Mono Nerd Font";
              style = "Regular";
            };
          };
          cursor.style.shape = "beam";
        };
      };
    }

    # Non-WSL hosts: install and configure kitty via home-manager normally.
    (lib.mkIf (!isWsl) {
      programs.kitty = {
        enable = true;
        settings = kittySettings;
      };
    })

    # WSL: kitty is installed the Ubuntu way (apt) so it links against the host's
    # Mesa/EGL drivers. The Nix-built kitty can't reach WSLg's GL stack — EGL init
    # fails and it segfaults. home-manager only manages the config file that the
    # system kitty reads at ~/.config/kitty/kitty.conf.
    (lib.mkIf isWsl {
      xdg.configFile."kitty/kitty.conf".text =
        lib.concatStringsSep "\n"
        (lib.mapAttrsToList (k: v: "${k} ${toString v}") kittySettings)
        + "\n";
    })
  ];
}
