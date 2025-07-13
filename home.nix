{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "dylan";
  home.homeDirectory = "/Users/dylan";


  programs.git = {
    enable = true;
    userName = "DylanSatow";
    userEmail = "dylansatow531@gmail.com";
  };

  programs.zsh = {
    enable = true;
    loginExtra = "cd ~/home";

    oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
    };
  };

  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Macchiato";
    settings = {
        # Fonts
        # font_family Monolisa Nerd Font Mono
        font_family = "JetBrainsMono Nerd Font";
        bold_font = "auto";
        italic_font = "auto";
        bold_italic_font = "auto";
        font_size = 19.0;

        # Cursor
        cursor_shape = "beam";
        cursor_trail = 1;
        background_opacity = 1;
        background_blur = 30;
    };
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