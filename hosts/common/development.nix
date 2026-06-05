{pkgs, ...}: let
  sets = import ../../lib/package-sets.nix {inherit pkgs;};
in {
  # texliveFull is system-only (large); the standalone home configs use the base set.
  environment.systemPackages = sets.development ++ [pkgs.unstable.texliveFull];
}
