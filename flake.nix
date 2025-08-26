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
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
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
    nixos-hardware,
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
          python3Packages.poetry-core
          
          rustc
          cargo
          rustfmt
          clippy
          
          go
          gopls
          
          gcc
          clang
          cmake
          pkg-config
          
          git
          curl
          jq
          tree
        ];
        
        shellHook = ''
          export PS1="\[\033[1;34m\][dev-shell]\[\033[0m\] \[\033[1;32m\]\u@\h\[\033[0m\]:\[\033[1;34m\]\w\[\033[0m\]\$ "
          echo "🚀 Development shell activated!"
          echo "Available tools:"
          echo "  Python: $(python3 --version)"
          echo "  Rust: $(rustc --version)"
          echo "  Go: $(go version)"
          echo "  GCC: $(gcc --version | head -n1)"
          echo "  Clang: $(clang --version | head -n1)"
        '';
      };
    };

    devShells.${linuxSystem} = {
      default = nixpkgs-linux.legacyPackages.${linuxSystem}.mkShell {
        buildInputs = with nixpkgs-linux.legacyPackages.${linuxSystem}; [
          python3
          python3Packages.pip
          python3Packages.virtualenv
          python3Packages.poetry-core
          
          rustc
          cargo
          rustfmt
          clippy
          
          go
          gopls
          
          gcc
          clang
          cmake
          pkg-config
          
          git
          curl
          jq
          tree
        ];
        
        shellHook = ''
          export PS1="\[\033[1;34m\][dev-shell]\[\033[0m\] \[\033[1;32m\]\u@\h\[\033[0m\]:\[\033[1;34m\]\w\[\033[0m\]\$ "
          echo "🚀 Development shell activated!"
          echo "Available tools:"
          echo "  Python: $(python3 --version)"
          echo "  Rust: $(rustc --version)"
          echo "  Go: $(go version)"
          echo "  GCC: $(gcc --version | head -n1)"
          echo "  Clang: $(clang --version | head -n1)"
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
        nixos-hardware.nixosModules.dell-xps-13-7390
        home-manager-linux.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users.dylan = {
            imports = [ ./home/linux.nix stylix.homeModules.stylix ];
          };
        }
      ];
    };

    nixosConfigurations."dylanpc" = nixpkgs-linux.lib.nixosSystem {
      system = linuxSystem;
      modules = [
        {
          nixpkgs.overlays = [ (overlaysModule.unstable-overlay linuxSystem) ];
          nixpkgs.config.allowUnfree = true;
        }
        ./shared/packages.nix
        ./hosts/dylanpc
        home-manager-linux.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users.dylan = {
            imports = [ ./home/linux.nix stylix.homeModules.stylix ];
          };
        }
      ];
    };
  };
}