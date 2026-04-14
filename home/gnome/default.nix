{pkgs, ...}: let
  colors = import ./colors.nix;
  # Actively maintained Catppuccin theme by Fausto-Korpsvart
  # Provides GTK3, GTK4, and GNOME Shell theming from a single source
  catppuccinTheme = import ./catppuccin-shell-theme.nix {inherit pkgs;};
  themePath = "${catppuccinTheme}/share/themes/${colors.themeName}";
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
      name = colors.themeName;
      package = catppuccinTheme;
    };
  };

  # GNOME Shell theme via User Themes extension
  home.packages = [
    pkgs.gnomeExtensions.user-themes
    pkgs.gnomeExtensions.dash-to-dock
    pkgs.gnomeExtensions.arcmenu
    pkgs.gnomeExtensions.space-bar
    pkgs.gnomeExtensions.vitals
    pkgs.gnomeExtensions.blur-my-shell
  ];
  dconf.settings."org/gnome/shell" = {
    enabled-extensions = [
      "user-theme@gnome-shell-extensions.gcampax.github.com"
      "dash-to-dock@micxgx.gmail.com"
      "arcmenu@arcmenu.com"
      "space-bar@luchrioh"
      "Vitals@CoreCoding.com"
      "blur-my-shell@aunetx"
    ];
  };
  dconf.settings."org/gnome/shell/extensions/user-theme" = {
    name = colors.themeName;
  };

  # Install the GNOME Shell theme so the extension can find it
  home.file.".themes/${colors.themeName}/gnome-shell".source = "${themePath}/gnome-shell";

  # Wallpaper
  home.file.".local/share/backgrounds/space.jpg".source = ../../assets/space.jpg;
}
