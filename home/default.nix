{
  lib,
  isDesktop,
  ...
}: {
  imports =
    [
      ./theme.nix
      ./apps
    ]
    ++ lib.optional isDesktop ./gnome;

  # username/homeDirectory are derived automatically from the system user when
  # home-manager runs as a NixOS/nix-darwin module, so they are not set here.
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}
