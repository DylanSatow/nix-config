{ ... } : {
    programs.helix = {
        enable = true;
        settings = {
            editor = {
                line-number = "relative";
                whitespace.render = "all";
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
                    formatter = {command = "alejandra";};
                    auto-format = true;
                }  
            ];
        };
    };
}
