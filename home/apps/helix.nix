{ ... } : {
    programs.helix = {
        enable = true;
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
                    formatter = {command = "alejandra";};
                    auto-format = true;
                }  
            ];
        };
    };
}
