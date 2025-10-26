{ ... }: {
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
                continue-comments = false;
                end-of-line-diagnostics = "hint";
            };
            keys.normal.space.q = ":write-quit";
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
                {
                    name = "c";
                    language-servers = [ "clangd" ];
                }
                {
                    name = "go";
                    language-servers = [ "gopls" "golangci-lint-lsp" ];
                }
            ];
        };
    };
}
