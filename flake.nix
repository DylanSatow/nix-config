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
  } @ inputs: let
    overlays = import ./overlays.nix {inherit nixpkgs-unstable;};

    # Semantic host flags passed to every home configuration via (extra)specialArgs.
    # Exactly one is expected to be true per host. Replaces hostname string comparison.
    mkFlags = {
      isDesktop ? false,
      isDarwin ? false,
      isServer ? false,
      isWsl ? false,
    }: {
      inherit isDesktop isDarwin isServer isWsl;
    };
  in {
    homeConfigurations."ubuntu@dylanserver" = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        system = "aarch64-linux";
        overlays = [(overlays.unstable-overlay "aarch64-linux")];
        config.allowUnfree = true;
      };
      extraSpecialArgs = mkFlags {isServer = true;};
      modules = [
        ./home/server
        catppuccin.homeModules.catppuccin
      ];
    };

    # dylanpc — Windows 11 + WSL Ubuntu, standalone home-manager (x86_64-linux, user "dylan").
    homeConfigurations."dylan@dylanpc" = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        overlays = [(overlays.unstable-overlay "x86_64-linux")];
        config.allowUnfree = true;
      };
      extraSpecialArgs = mkFlags {isWsl = true;};
      modules = [
        ./home/wsl
        catppuccin.homeModules.catppuccin
      ];
    };

    # nixos-pc — archived NixOS desktop (GNOME / NVIDIA / gaming). The physical machine
    # now runs Windows + WSL (see homeConfigurations."dylan@dylanpc"); kept buildable.
    nixosConfigurations.nixos-pc = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/nixos-pc
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
          home-manager.extraSpecialArgs = mkFlags {isDesktop = true;};
        }
      ];
      specialArgs = {inherit inputs;};
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
            overlays.direnv-overlay
            nix4vscode.overlays.default
          ];
          nixpkgs.config.allowUnfree = true;
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.dylan.imports = [
            ./home
            catppuccin.homeModules.catppuccin
          ];
          home-manager.extraSpecialArgs = mkFlags {isDarwin = true;};
        }
      ];
      specialArgs = {
        inherit self homebrew-core homebrew-cask;
      };
    };
  };
}
