{pkgs, ...}: let
  # Actively maintained Catppuccin theme by Fausto-Korpsvart
  # Provides GTK3, GTK4, and GNOME Shell theming from a single source
  catppuccinTheme = import ./catppuccin-shell-theme.nix {inherit pkgs;};
  themeName = "Catppuccin-Lavender-Dark";
  themePath = "${catppuccinTheme}/share/themes/${themeName}";
in {
  imports = [
    ./dconf.nix
  ];

  # Theme libadwaita apps (Nautilus, Settings, etc.) by placing
  # Catppuccin CSS + assets into ~/.config/gtk-4.0/
  xdg.configFile = {
    "gtk-4.0/assets".source = "${themePath}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${themePath}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${themePath}/gtk-4.0/gtk-dark.css";
  };

  # GTK3 theme
  gtk = {
    enable = true;
    theme = {
      name = themeName;
      package = catppuccinTheme;
    };
  };

  # GNOME Shell theme via User Themes extension
  home.packages = [pkgs.gnomeExtensions.user-themes];
  dconf.settings."org/gnome/shell" = {
    enabled-extensions = ["user-theme@gnome-shell-extensions.gcampax.github.com"];
  };
  dconf.settings."org/gnome/shell/extensions/user-theme" = {
    name = themeName;
  };

  # Install the GNOME Shell theme so the extension can find it
  home.file.".themes/${themeName}/gnome-shell".source = "${themePath}/gnome-shell";

  # Wallpaper
  home.file.".local/share/backgrounds/space.jpg".source = ../../assets/space.jpg;
}
