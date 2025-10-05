{
    description = "Multi-system nix configuration for macOS and NixOS";

    inputs = {
        nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
        nixpkgs-linux.url = "github:NixOS/nixpkgs/nixos-25.05";
        nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        
        nix-darwin = {
            url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
            inputs.nixpkgs.follows = "nixpkgs-darwin";
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

        home-manager-darwin = {
            url = "github:nix-community/home-manager/release-25.05";
            inputs.nixpkgs.follows = "nixpkgs-darwin";
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
        nixpkgs-darwin,
        nixpkgs-linux,
        nixpkgs-unstable,
        nix-darwin, 
        nix-homebrew, 
        homebrew-core, 
        homebrew-cask,
        home-manager-darwin,
        home-manager-linux,
        stylix,
        nixos-hardware,
        ...
    }:
    let
        overlaysModule = import ./overlays.nix { inherit nixpkgs-unstable; };
    in
    {
        darwinConfigurations.dylanix = nix-darwin.lib.darwinSystem {
            system = "aarch64-darwin";
            modules = [ 
                {
                    nixpkgs.overlays = [ (overlaysModule.unstable-overlay "aarch64-darwin") ];
                    nixpkgs.config.allowUnfree = true;
                }
                ./shared/default.nix
                ./hosts/dylanix
                nix-homebrew.darwinModules.nix-homebrew 
                home-manager-darwin.darwinModules.home-manager
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
                ./shared/default.nix
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
                ./shared/default.nix
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

        homeConfigurations.dylanserver = home-manager-linux.lib.homeManagerConfiguration {
            pkgs = nixpkgs-linux.legacyPackages.aarch64-linux.extend (overlaysModule.unstable-overlay "aarch64-linux");
            modules = [
                ./home/server.nix
                {
                    home = {
                        username = nixpkgs-linux.lib.mkForce "ubuntu";
                        homeDirectory = nixpkgs-linux.lib.mkForce "/home/ubuntu";
                        stateVersion = "25.05";
                    };
                    nixpkgs.config.allowUnfree = true;
                }
            ];
            extraSpecialArgs = { hostname = "dylanserver"; };
        };
    };
}
