{ self, homebrew-core, homebrew-cask, ... }: {
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    casks = [
      "firefox"
      "google-chrome"
      "kitty"
      "spotify"
      "nikitabobko/tap/aerospace"
      "claude"
      "visual-studio-code"
      "obsidian"
      "slack"
      "zoom"
      "discord"
      "steam"
      "displaylink"
      "nordvpn"
      "superhuman"
    ];
  };

  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = "dylan";
    taps = {
      "homebrew/homebrew-core" = homebrew-core;
      "homebrew/homebrew-cask" = homebrew-cask;
    };
    mutableTaps = true;
  };
}
