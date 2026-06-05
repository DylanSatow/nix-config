# Shared catppuccin theming, imported by every home configuration (NixOS/darwin via
# home/default.nix, standalone HM via home/common). Requires catppuccin.homeModules.catppuccin
# to be present in the config's module set.
{...}: {
  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "lavender";
  };
}
