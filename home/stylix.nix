{ pkgs, ... }:

{
    stylix = {
        enable = true;
        image = ./wallpapers/jazz.jpg;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
        fonts = {
            serif = {
                package = pkgs.noto-fonts;
                name = "Noto Serif";
            };
            sansSerif = {
                package = pkgs.noto-fonts;
                name = "Noto Sans";
            };
            monospace = {
                package = pkgs.nerd-fonts.jetbrains-mono;
                name = "JetBrainsMono Nerd Font";
            };
            sizes = {
                applications = 12;
                terminal = 14;
                desktop = 12;
                popups = 12;
            };
        };
    };
}
