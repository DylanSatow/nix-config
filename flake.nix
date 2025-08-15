{
  description = "Multi-system nix configuration for macOS and NixOS";

  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    nixpkgs-linux.url = "github:NixOS/nixpkgs/nixos-25.05";
    
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

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-linux = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs-linux";
    };
    stylix = {
      url = "github:danth/stylix/release-25.05";
    };
  };

  outputs = inputs@{ 
    self, 
    nix-darwin, 
    nixpkgs,
    nixpkgs-linux,
    nixpkgs-unstable,
    home-manager,
    home-manager-linux,
    nix-homebrew, 
    homebrew-core, 
    homebrew-cask,
    stylix,
  }:
  let
    darwinSystem = "aarch64-darwin";
    linuxSystem = "x86_64-linux";
    
    overlaysModule = import ./shared/overlays.nix {
      inherit nixpkgs-unstable;
    };
  in
  {
    devShells.${darwinSystem} = {
      default = nixpkgs.legacyPackages.${darwinSystem}.mkShell {
        buildInputs = with nixpkgs.legacyPackages.${darwinSystem}; [
          python3
          python3Packages.pip
          python3Packages.virtualenv
          python3Packages.poetry
          
          rustc
          cargo
          rustfmt
          clippy
          
          go
          gopls
          
          git
          curl
          jq
          tree
        ];
        
        shellHook = ''
          echo "🚀 Development shell activated!"
          echo "Available tools:"
          echo "  Python: $(python3 --version)"
          echo "  Rust: $(rustc --version)"
          echo "  Go: $(go version)"
        '';
      };
    };

    darwinConfigurations."dylanix" = nix-darwin.lib.darwinSystem {
      system = darwinSystem;
      modules = [ 
        {
          nixpkgs.overlays = [ (overlaysModule.unstable-overlay darwinSystem) ];
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
        }
      ];
      specialArgs = { inherit self homebrew-core homebrew-cask; };
    };

    nixosConfigurations."dylanxps" = nixpkgs-linux.lib.nixosSystem {
      system = linuxSystem;
      modules = [
        {
          nixpkgs.overlays = [ (overlaysModule.unstable-overlay linuxSystem) ];
          nixpkgs.config.allowUnfree = true;
        }
        ./shared/packages.nix
        ./hosts/dylanxps
        stylix.nixosModules.stylix
        home-manager-linux.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users.dylan = import ./home/linux.nix;
        }
      ];
    };
  };
}