{
    description = "Dylanix";
    inputs = {
        nixpkgs-darwin-pkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.11-darwin";
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
        nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        nixos-hardware.url = "github:NixOS/nixos-hardware/master";
        home-manager = {
            url = "github:nix-community/home-manager/release-25.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # Editors
        nix4vscode = {
            url = "github:nix-community/nix4vscode";
            inputs.nixpkgs.follows = "nixpkgs";            
        };

        # THEMING 
        stylix = {
            url = "github:nix-community/stylix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        catppuccin = {
            url = "github:catppuccin/nix/release-25.05";
            inputs.nixpkgs.follows = "nixpkgs-unstable";
        };

        # Mac Stuff 
        nix-darwin = {
            url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
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
        nix4vscode,
        home-manager,
        nixpkgs-unstable,
        catppuccin,

        # mac 
        nix-darwin, 
        nix-homebrew, 
        homebrew-core, 
        homebrew-cask,
        ...
    } @ inputs:
    let
        overlays = import ./overlays.nix { inherit nixpkgs-unstable; };
    in
    {
        nixosConfigurations.dylanpc = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                ./hosts/dylanpc
                catppuccin.nixosModules.catppuccin
                home-manager.nixosModules.home-manager
                {
                    nixpkgs.overlays = [
                        (overlays.unstable-overlay "x86_64-linux")
                        nix4vscode.overlays.default
                    ];
                    nixpkgs.config.allowUnfree = true;
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.dylan.imports = [
                        ./home
                        catppuccin.homeModules.catppuccin
                    ];
                    home-manager.extraSpecialArgs = { hostname = "dylanpc"; };
                }

            ];
            specialArgs = { inherit inputs; };                
        };

        darwinConfigurations.dylanmac = nix-darwin.lib.darwinSystem {
            system = "aarch64-darwin";
            modules = [ 
                ./hosts/dylanmac
                nix-homebrew.darwinModules.nix-homebrew 
                home-manager.darwinModules.home-manager
                {
                    users.users.dylan = {
                        name = "dylan";
                        home = "/Users/dylan";
                    };                   
                    nixpkgs.overlays = [
                        (overlays.unstable-overlay "aarch64-darwin")
                        nix4vscode.overlays.default
                    ];
                    nixpkgs.config.allowUnfree = true;
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.dylan.imports = [
                        ./home
                        catppuccin.homeModules.catppuccin
                    ];
                    home-manager.extraSpecialArgs = { hostname = "dylanmac"; };
                }
            ];
            specialArgs = { 
                inherit self homebrew-core homebrew-cask; 
            };
        };
    };
}
