{ config, lib, pkgs, ... }: {

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  home.file.".config/nvim" = {
    source = ../home-manager/nvim;
    recursive = true;
  };

  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
        
        vscodevim.vim
        
        ms-vscode-remote.remote-containers
        ms-vscode-remote.remote-ssh
        ms-vscode-remote.remote-wsl
        ms-vscode-remote.vscode-remote-extensionpack
        
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
        "workbench.colorTheme" = "Catppuccin Macchiato";
        "workbench.iconTheme" = "catppuccin-macchiato";
        "workbench.productIconTheme" = "material-product-icons";
        
        "workbench.sideBar.location" = "right";
        
        "vim.useSystemClipboard" = true;
        "vim.hlsearch" = true;
        "vim.insertModeKeyBindings" = [
          {
            "before" = ["j" "j"];
            "after" = ["<Esc>"];
          }
        ];
        
        "editor.fontSize" = 14;
        "editor.fontFamily" = "JetBrainsMono Nerd Font";
        "editor.lineNumbers" = "on";
        "editor.minimap.enabled" = true;
        
        "python.defaultInterpreterPath" = "/usr/bin/python3";
        "python.formatting.provider" = "black";
        
        "go.formatTool" = "goimports";
        "go.useLanguageServer" = true;
        
        "C_Cpp.default.cppStandard" = "c++17";
        "C_Cpp.default.cStandard" = "c11";
      };
    };
  };
}