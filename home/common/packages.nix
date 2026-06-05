{pkgs, ...}: let
  sets = import ../../lib/package-sets.nix {inherit pkgs;};
in {
  home.packages = sets.cliTools ++ sets.development;
}
