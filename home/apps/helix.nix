{ ... } : {
    programs.helix = {
        enable = true;
        defaultEditor = true;
        settings = {
            editor = {
                line-number = "relative";
                cursor-shape = {
                    insert = "bar";
                    normal = "block";
                    select = "underline";
                };
            };
        };

        languages = {
            language = [
                {
                    name = "nix";
                    language-servers = [ "nil" ];
                }
                {
                    name = "python";
                    language-servers = [ "pyright" ];
                }
                {
                    name = "rust";
                }
                {
                    name = "markdown";
                    language-servers = [ "markdown-oxide" ];
                }
            ];
        };
    };
}
