{ self, homebrew-core, homebrew-cask, ... }: {
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    casks = [
      "firefox"
      "google-chrome"
      "kitty"
      "spotify"
      "rectangle"
      "claude"
      "visual-studio-code"
      "obsidian"
      "todoist"
      "slack"
      "zoom"
      "discord"
      "steam"
      "alt-tab"
      "displaylink"
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
    mutableTaps = false;
  };
}
