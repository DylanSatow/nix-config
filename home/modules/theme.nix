# Shared catppuccin theming, imported by every host via home/common.nix. Themes the
# terminal CLI tools; requires catppuccin.homeModules.catppuccin in the module set.
{...}: {
  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "lavender";
  };
}
