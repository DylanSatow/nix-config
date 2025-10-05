{ config, lib, pkgs, hostname ? "", ... }: {
    imports = [
        ./nvim/nvim.nix
    ];

    programs.vscode = {
        enable = hostname != "dylanserver";
        profiles.default = {
            extensions = with pkgs.vscode-extensions; [
                catppuccin.catppuccin-vsc
                catppuccin.catppuccin-vsc-icons
                
                vscodevim.vim
                
                ms-vscode-remote.remote-containers
                ms-vscode-remote.remote-ssh
                ms-vscode-remote.remote-wsl
                ms-vscode-remote.vscode-remote-extensionpack

                # Jupyter Notebooks 
                ms-toolsai.jupyter
                ms-toolsai.vscode-jupyter-slideshow
                ms-toolsai.vscode-jupyter-cell-tags
                ms-toolsai.jupyter-renderers
                ms-toolsai.jupyter-keymap

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
            ];
            
            userSettings = {
                "workbench.colorTheme" = lib.mkDefault "Catppuccin Macchiato";
                "workbench.iconTheme" = lib.mkDefault "catppuccin-macchiato";
                "workbench.sideBar.location" = "right";
                
                "vim.useSystemClipboard" = true;
                "vim.hlsearch" = true;
                
                "editor.lineNumbers" = "on";
                "editor.minimap.enabled" = true;
                
                "python.defaultInterpreterPath" = "/usr/bin/python3";
                "python.formatting.provider" = "black";
                "leetcode.workspaceFolder" = "/Users/dylan/.leetcode";
                "go.formatTool" = "goimports";
                "go.useLanguageServer" = true;
                
                "C_Cpp.default.cppStandard" = "c++17";
                "C_Cpp.default.cStandard" = "c11";
            } // (if hostname != "dylanix" then {
                "vim.useCtrlKeys" = false;
                "vim.handleKeys" = {
                    "<C-w>" = false;
                    "<C-t>" = false;
                    "<C-n>" = false;
                    "<C-s>" = false;
                    "<C-z>" = false;
                    "<C-y>" = false;
                    "<C-x>" = false;
                    "<C-c>" = false;
                    "<C-v>" = false;
                    "<C-a>" = false;
                    "<C-f>" = false;
                    "<C-h>" = false;
                    "<C-k>" = false;
                    "<C-p>" = false;
                    "<C-r>" = false;
                    "<C-g>" = false;
                    "<C-d>" = false;
                    "<C-u>" = false;
                    "<C-b>" = false;
                    "<C-j>" = false;
                    "<C-o>" = false;
                    "<C-i>" = false;
                };
                "vim.insertModeKeyBindings" = [
                    {
                        "before" = ["j" "j"];
                        "after" = ["<Esc>"];
                    }
                ];
            } else {});
        };
    };
}
