{ config, lib, pkgs, ... }: {

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    
    # Let LazyVim manage all plugins
    plugins = [ ];
    
    # Use the LazyVim configuration files
    extraLuaConfig = ''
      -- Set the path to the LazyVim config directory
      vim.opt.runtimepath:prepend("${./nvim}")
      
      -- Bootstrap lazy.nvim and LazyVim
      require("config.lazy")
    '';
  };

  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        # Catppuccin theme
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
        
        # Vim extension
        vscodevim.vim
        
        # Remote explorer
        ms-vscode-remote.remote-containers
        ms-vscode-remote.remote-ssh
        ms-vscode-remote.remote-wsl
        ms-vscode-remote.vscode-remote-extensionpack
        
        # Material product icons
        pkief.material-icon-theme
        pkief.material-product-icons
        
        # Language extensions
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
        # Catppuccin theme configuration
        "workbench.colorTheme" = "Catppuccin Macchiato";
        "workbench.iconTheme" = "catppuccin-macchiato";
        "workbench.productIconTheme" = "material-product-icons";
        
        # Sidebar on right
        "workbench.sideBar.location" = "right";
        
        # Vim configuration
        "vim.useSystemClipboard" = true;
        "vim.hlsearch" = true;
        "vim.insertModeKeyBindings" = [
          {
            "before" = ["j" "j"];
            "after" = ["<Esc>"];
          }
        ];
        
        # Editor settings
        "editor.fontSize" = 14;
        "editor.fontFamily" = "JetBrainsMono Nerd Font";
        "editor.lineNumbers" = "on";
        "editor.minimap.enabled" = true;
        
        # Python settings
        "python.defaultInterpreterPath" = "/usr/bin/python3";
        "python.formatting.provider" = "black";
        
        # Go settings
        "go.formatTool" = "goimports";
        "go.useLanguageServer" = true;
        
        # C/C++ settings
        "C_Cpp.default.cppStandard" = "c++17";
        "C_Cpp.default.cStandard" = "c11";
      };
    };
  };

}