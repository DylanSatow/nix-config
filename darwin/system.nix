{ self, ... }: {
  # Dock configuration
  system.defaults.dock = {
    autohide = true;
    launchanim = false;
    show-recents = false;
    tilesize = 64;
    magnification = false;
    orientation = "bottom";
    mineffect = "scale";
    show-process-indicators = true;

    # Configure specific apps in dock
    persistent-apps = [
      { app = "/Applications/Firefox.app"; }
      { app = "/System/Applications/Mail.app"; }
      { app = "/Applications/Kitty.app"; }
      { app = "/Applications/Visual Studio Code.app"; }
      { app = "/Applications/Claude.app"; }
    ];
  };

  system.defaults.WindowManager.EnableTilingByEdgeDrag = false;

  # Finder configuration
  system.defaults.finder = {
    FXPreferredViewStyle = "clmv";
    NewWindowTarget = "Other";
    NewWindowTargetPath = "file:///Users/dylan/home/";
    ShowPathbar = true;
  };

  # Control Center configuration
  system.defaults.controlcenter.BatteryShowPercentage = true;

  # Disable accent popup when holding keys (enables key repeat)
  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
  system.defaults.NSGlobalDomain.KeyRepeat = 2;
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 15;

  system.primaryUser = "dylan";

  # Necessary for using flakes on this system
  nix.settings.experimental-features = "nix-command flakes";

  # Set Git commit hash for darwin-version
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility
  system.stateVersion = 6;

  # The platform the configuration will be used on
  nixpkgs.hostPlatform = "aarch64-darwin";
}