{pkgs, ...}: let
  sets = import ../../lib/package-sets.nix {inherit pkgs;};
in {
  # zellij is added here for the system profile; in home configs it is owned by
  # programs.zellij (home/apps/shell.nix), so it is kept out of the shared list.
  environment.systemPackages = sets.cliTools ++ [pkgs.unstable.zellij];
}
