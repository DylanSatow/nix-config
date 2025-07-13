{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:

  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#dylanix
    darwinConfigurations."dylanix" = nix-darwin.lib.darwinSystem {
	modules = [ ./mac-configuration.nix ];
	specialArgs = { inherit self; };
    };
  };
}
