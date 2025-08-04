{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
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

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ 
    self, 
    nix-darwin, 
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    # Homebrew
    nix-homebrew, 
    homebrew-core, 
    homebrew-cask,
  }:
  let
  system = "aarch64-darwin"; # or "x86_64-darwin" for Intel Macs
  
  # Create overlay that adds unstable packages to stable nixpkgs
  unstable-overlay = final: prev: {
    unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
  };
  in
  {
    # Development shells available with: nix develop
    devShells.${system} = {
      default = nixpkgs.legacyPackages.${system}.mkShell {
        buildInputs = with nixpkgs.legacyPackages.${system}; [
          # Python development
          python3
          python3Packages.pip
          python3Packages.virtualenv
          python3Packages.poetry
          
          # Rust development  
          rustc
          cargo
          rustfmt
          clippy
          
          # Go development
          go
          gopls
          
          # Common development tools
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

    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#dylanix
    darwinConfigurations."dylanix" = nix-darwin.lib.darwinSystem {
      inherit system;
      modules = [ 
        {
          nixpkgs.overlays = [ unstable-overlay ];
          nixpkgs.config.allowUnfree = true;
        }
        ./darwin/darwin.nix 
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
          home-manager.users.dylan = import ./home-manager/home.nix;
        }
      ];
	    specialArgs = { inherit self homebrew-core homebrew-cask; };
    };
  };
}
