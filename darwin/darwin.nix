{ ... }: {
  # Import all darwin-specific modules
  imports = [
    ./pkgs.nix
    ./casks.nix
    ./system.nix
  ];
}