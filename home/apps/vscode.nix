{ pkgs, ... } : {
    programs.vscode = {
        enable = true;
        profiles.default = {
            extensions = with pkgs.vscode-extensions; [
                ms-vscode-remote.remote-containers
                ms-vscode-remote.remote-ssh
                ms-vscode-remote.remote-wsl
                ms-vscode-remote.vscode-remote-extensionpack

                james-yu.latex-workshop
                
                pkief.material-icon-theme
                pkief.material-product-icons
                
                ms-python.python
                ms-python.pylint
                ms-python.black-formatter
                bbenoist.nix
                golang.go
                ms-vscode.cpptools
                ms-vscode.cpptools-extension-pack
                ms-vscode.cmake-tools
            ] ++ pkgs.nix4vscode.forVscode [
                "jasew.vscode-helix-emulation"
                "ms-vscode.atom-keybindings"
                "LeetCode.vscode-leetcode"
            ];
            
            userSettings = {
                "workbench.sideBar.location" = "right";
                
                "terminal.integrated.stickyScroll.enabled" = false;

                "vim.useSystemClipboard" = true;
                "vim.hlsearch" = true;
                
                "editor.fontFamily" = "JetBrainsMono Nerd Font";
                "editor.lineNumbers" = "on";
                "editor.minimap.enabled" = true;
                
                "python.defaultInterpreterPath" = "/usr/bin/python3";
                "python.formatting.provider" = "black";
                "go.formatTool" = "goimports";
                "go.useLanguageServer" = true;

                "latex-workshop.latex.autoClean.run" = "onBuilt";
                "latex-workshop.latex.autoBuild.run" = "onSave";
                "C_Cpp.default.cppStandard" = "c++17";
                "C_Cpp.default.cStandard" = "c11";
            };
        };
    };
}
