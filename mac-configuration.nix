{ pkgs, self, homebrew-core, homebrew-cask, ... }: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget

  environment.systemPackages = [ 
    pkgs.vim 
    pkgs.neovim 
    pkgs.nixfmt-rfc-style
    
    pkgs.unstable.claude-code
  ];

  homebrew = {
    enable = true;
    casks = [
      { name = "firefox"; }
      { name = "kitty"; }
      { name = "spotify"; }
      { name = "rectangle"; }
      { name = "claude"; }
      { name = "visual-studio-code"; }
    ];
  };

  # Dock configuration
  system.defaults.dock = {
    autohide = true;
    launchanim = false;
    show-recents = false; # Don't show recent apps
    tilesize = 48; # Icon size (default is 64)
    magnification = false; # Enable magnification on hover
    orientation = "bottom"; # Position: "bottom", "left", "right"
    mineffect = "scale"; # Minimize effect: "genie", "scale", "suck"
    show-process-indicators = true; # Show dots under running apps
  };

  system.defaults.WindowManager.EnableTilingByEdgeDrag = false;

  # Control Center configuration
  system.defaults.controlcenter.BatteryShowPercentage = true;

  # Disable accent popup when holding keys (enables key repeat)
  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
  system.defaults.NSGlobalDomain.KeyRepeat = 2; # Fast key repeat rate (1 is fastest, 2 is very fast)
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 15; # Short delay before repeat starts

  system.primaryUser = "dylan"; # Set main user for dock

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  nix-homebrew = {
    enable = true;

    enableRosetta = true;

    user = "dylan";

    taps = {
      "homebrew/homebrew-core" = homebrew-core;
      "homebrew/homebrew-cask" = homebrew-cask;
    };
    mutableTaps = false;
  };
}

