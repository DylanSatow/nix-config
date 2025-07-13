{ config, pkgs, ... }: {
  # Import all home-manager modules
  imports = [
    ./editors.nix
    ./browsers.nix
    ./terminal.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "dylan";
  home.homeDirectory = "/Users/dylan";

  programs.git = {
    enable = true;
    userName = "DylanSatow";
    userEmail = "dylansatow531@gmail.com";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };



  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}