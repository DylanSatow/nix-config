{ pkgs, ... } : {
    gtk = {
        enable = true;

        theme = {
            name = "Catppuccin-Mocha";
            package = pkgs.catppuccin-gtk.override {
                accents = [ "lavender" ]; 
                size = "standard";
                variant = "mocha"; # Or your preferred flavor
            };
        };

        # iconTheme = {
        #     name = "cat-mocha-lavender";
        #     package = pkgs.catppuccin-papirus-folders.override {
        #         accent = "lavender";
        #         flavor = "mocha";
        #     };
        # };
    };
}