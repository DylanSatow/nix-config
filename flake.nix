{
    description = "Dylanix";
    inputs = {
        nixpkgs-darwin-pkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
        nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        nixos-hardware.url = "github:NixOS/nixos-hardware/master";
        home-manager = {
            url = "github:nix-community/home-manager/release-25.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # THEMING 
        stylix = {
            url = "github:nix-community/stylix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        catppuccin.url = "github:catppuccin/nix";


        # Mac Stuff 
        nix-darwin = {
            url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };

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
    outputs = {
        self,
        nixpkgs,
        nixpkgs-unstable,
        ...
    }@inputs:
    let
        overlays = import ./overlays.nix { inherit nixpkgs-unstable; };
    in
    {
        nixosConfigurations.dylanpc = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                ./hosts/dylanpc
                {
                    nixpkgs.overlays = [
                        (overlays.unstable-overlay "x86_64-linux")
                    ];
                }
            ];
            specialArgs = { inherit inputs; };
        };
    };
}
