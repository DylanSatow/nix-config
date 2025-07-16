{ config, pkgs, ... }: {

  # Neovim text editor configuration
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    defaultEditor = false;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;

    extraPackages = with pkgs; [
      alejandra
      black
      golangci-lint
      gopls
      gotools
      hadolint
      isort
      lua-language-server
      markdownlint-cli
      nixd
      nodePackages.bash-language-server
      nodePackages.prettier
      pyright
      ruff
      shellcheck
      shfmt
      stylua
      terraform-ls
      tflint
      vscode-langservers-extracted
      yaml-language-server
    ];
  };

  # source lua config from this repo
  xdg.configFile = {
    "nvim" = {
      source = ./lazyvim;
      recursive = true;
    };
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