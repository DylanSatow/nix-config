{
    description = "Multi-system nix configuration for macOS and NixOS";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
        nixpkgs-linux.url = "github:NixOS/nixpkgs/nixos-25.05";
        nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        
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

        home-manager = {
            url = "github:nix-community/home-manager/release-25.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        home-manager-linux = {
            url = "github:nix-community/home-manager/release-25.05";
            inputs.nixpkgs.follows = "nixpkgs-linux";
        };
        
        stylix.url = "github:danth/stylix/release-25.05";
        nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    };

    outputs = { 
        self,
        nixpkgs,
        nixpkgs-linux,
        nixpkgs-unstable,
        nix-darwin, 
        nix-homebrew, 
        homebrew-core, 
        homebrew-cask,
        home-manager,
        home-manager-linux,
        stylix,
        nixos-hardware,
        ...
    }:
    let
        overlaysModule = import ./shared/overlays.nix { inherit nixpkgs-unstable; };
    in
    {
        darwinConfigurations.dylanix = nix-darwin.lib.darwinSystem {
            system = "aarch64-darwin";
            modules = [ 
                {
                    nixpkgs.overlays = [ (overlaysModule.unstable-overlay "aarch64-darwin") ];
                    nixpkgs.config.allowUnfree = true;
                }
                ./shared/packages.nix
                ./hosts/dylanix
                nix-homebrew.darwinModules.nix-homebrew 
                home-manager.darwinModules.home-manager
                {
                    users.users.dylan = {
                        name = "dylan";
                        home = "/Users/dylan";
                    };
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.backupFileExtension = null;
                    home-manager.users.dylan = import ./home/darwin.nix;
                    home-manager.extraSpecialArgs = { hostname = "dylanix"; };
                }
            ];
            specialArgs = { 
                inherit self homebrew-core homebrew-cask; 
            };
        };

        nixosConfigurations.dylanxps = nixpkgs-linux.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                ./shared/packages.nix
                ./hosts/dylanxps
                nixos-hardware.nixosModules.dell-xps-13-7390
                home-manager-linux.nixosModules.home-manager
                {
                    nixpkgs.overlays = [ (overlaysModule.unstable-overlay "x86_64-linux") ];
                    nixpkgs.config.allowUnfree = true;
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.backupFileExtension = "backup";
                    home-manager.users.dylan = {
                        imports = [ ./home/linux.nix stylix.homeModules.stylix ];
                    };
                    home-manager.extraSpecialArgs = { hostname = "dylanxps"; };
                }
            ];
            specialArgs = {};
        };

        nixosConfigurations.dylanpc = nixpkgs-linux.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                ./shared/packages.nix
                ./hosts/dylanpc
                home-manager-linux.nixosModules.home-manager
                {
                    nixpkgs.overlays = [ (overlaysModule.unstable-overlay "x86_64-linux") ];
                    nixpkgs.config.allowUnfree = true;
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.backupFileExtension = "backup";
                    home-manager.users.dylan = {
                        imports = [ ./home/linux.nix stylix.homeModules.stylix ];
                    };
                    home-manager.extraSpecialArgs = { hostname = "dylanpc"; };
                }
            ];
            specialArgs = {};
        };
    };
}