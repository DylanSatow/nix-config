{ self, ... }: {
  system.defaults.dock = {
    autohide = true;
    launchanim = false;
    show-recents = false;
    tilesize = 64;
    magnification = false;
    orientation = "bottom";
    mineffect = "scale";
    show-process-indicators = true;

    persistent-apps = [
      { app = "/Applications/Firefox.app"; }
      { app = "/System/Applications/Mail.app"; }
      { app = "/Applications/Kitty.app"; }
      { app = "/Applications/Visual Studio Code.app"; }
      { app = "/Applications/Claude.app"; }
    ];
  };

  system.defaults.WindowManager.EnableTilingByEdgeDrag = false;

  system.defaults.finder = {
    FXPreferredViewStyle = "clmv";
    NewWindowTarget = "Other";
    NewWindowTargetPath = "file:///Users/dylan/home/";
    ShowPathbar = true;
  };

  system.defaults.controlcenter.BatteryShowPercentage = true;

  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
  system.defaults.NSGlobalDomain.KeyRepeat = 2;
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 15;

  system.primaryUser = "dylan";

  nix.settings.experimental-features = "nix-command flakes";

  system.configurationRevision = self.rev or self.dirtyRev or null;

  system.stateVersion = 6;

  nixpkgs.hostPlatform = "aarch64-darwin";
}