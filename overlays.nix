{ nixpkgs-unstable }: {
    unstable-overlay = system: final: prev: {
        unstable = import nixpkgs-unstable {
                inherit system;
                config.allowUnfree = true;
        };
    };
}
