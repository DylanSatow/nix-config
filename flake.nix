{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, homebrew-core, homebrew-cask }:

  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#dylanix
    darwinConfigurations."dylanix" = nix-darwin.lib.darwinSystem {
	modules = [ ./mac-configuration.nix nix-homebrew.darwinModules.nix-homebrew ];
	specialArgs = { inherit self homebrew-core homebrew-cask; };
    };
  };
}
