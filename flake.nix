{
  description = "Dylanix";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # THEMING — still themes terminal CLI tools and seeds the neovim colorscheme.
    catppuccin = {
      url = "github:catppuccin/nix/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };
  outputs = {
    nixpkgs,
    home-manager,
    nixpkgs-unstable,
    catppuccin,
    ...
  }: let
    overlays = import ./overlays.nix {inherit nixpkgs-unstable;};

    # Semantic host flags passed to every home configuration via extraSpecialArgs.
    # Exactly one is expected to be true per host. Replaces hostname string comparison.
    mkFlags = {
      isDarwin ? false,
      isServer ? false,
      isWsl ? false,
    }: {
      inherit isDarwin isServer isWsl;
    };

    mkPkgs = system: extraOverlays:
      import nixpkgs {
        inherit system;
        overlays = [(overlays.unstable-overlay system)] ++ extraOverlays;
        config.allowUnfree = true;
      };
  in {
    # dylanserver — headless Ubuntu aarch64, standalone home-manager (user "ubuntu").
    homeConfigurations."ubuntu@dylanserver" = home-manager.lib.homeManagerConfiguration {
      pkgs = mkPkgs "aarch64-linux" [];
      extraSpecialArgs = mkFlags {isServer = true;};
      modules = [
        ./home/server.nix
        catppuccin.homeModules.catppuccin
      ];
    };

    # dylanpc — Windows 11 + WSL Ubuntu, standalone home-manager (x86_64-linux, user "dylan").
    homeConfigurations."dylan@dylanpc" = home-manager.lib.homeManagerConfiguration {
      pkgs = mkPkgs "x86_64-linux" [];
      extraSpecialArgs = mkFlags {isWsl = true;};
      modules = [
        ./home/wsl.nix
        catppuccin.homeModules.catppuccin
      ];
    };

    # dylanmac — Apple Silicon mac, standalone home-manager (aarch64-darwin, user "dylan").
    # No nix-darwin: nix manages only the CLI/dev toolchain and dotfiles; GUI apps are
    # installed by hand. Built with: home-manager switch --flake ~/home/nix-config#dylan@dylanmac
    homeConfigurations."dylan@dylanmac" = home-manager.lib.homeManagerConfiguration {
      pkgs = mkPkgs "aarch64-darwin" [overlays.direnv-overlay];
      extraSpecialArgs = mkFlags {isDarwin = true;};
      modules = [
        ./home/mac.nix
        catppuccin.homeModules.catppuccin
      ];
    };
  };
}
