{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "dylan";
  home.homeDirectory = "/Users/dylan";


  programs.git = {
    enable = true;
    userName = "DylanSatow";
    userEmail = "dylansatow531@gmail.com";
  };

  programs.zsh = {
    enable = true;

    oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
    };

    # Change to ~/home directory for new terminal sessions
    # but skip if we're in a specific working directory (e.g., VS Code terminal)
    initContent = ''
      # Override cd to go to /Users/dylan/home when no arguments provided
      function cd() {
        if [[ $# -eq 0 ]]; then
          builtin cd "/Users/dylan/home"
        else
          builtin cd "$@"
        fi
      }
      
      # Only change directory if we're in the default home directory
      # and not already in a subdirectory (preserves editor terminal behavior)
      if [[ "$PWD" == "$HOME" && -z "$VSCODE_INJECTION" ]]; then
        if [[ -d "$HOME/home" ]]; then
          cd "$HOME/home"
        fi
      fi
    '';
  };

  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Macchiato";
    settings = {
        # Fonts
        # font_family Monolisa Nerd Font Mono
        font_family = "JetBrainsMono Nerd Font";
        bold_font = "auto";
        italic_font = "auto";
        bold_italic_font = "auto";
        font_size = 19.0;

        # Cursor
        cursor_shape = "beam";
        cursor_trail = 1;
        background_opacity = 1;
        background_blur = 30;
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

  programs.firefox = {
    enable = true;
    
    profiles.dylan = {
      isDefault = true;
      
      # Extensions
      extensions = {
        packages = with pkgs; [
          # Note: You'll need to install Vimium manually from Firefox Add-ons store
          # or configure NUR for declarative extension management
        ];
      };
      
      # User preferences for minimal, sleek setup
      settings = {
        # Disable password manager
        "signon.rememberSignons" = false;
        "signon.generation.enabled" = false;
        "signon.management.page.breach-alerts.enabled" = false;
        
        # Minimal UI
        "browser.tabs.inTitlebar" = 1;
        "browser.uidensity" = 1; # Compact density
        "browser.toolbars.bookmarks.visibility" = "never";
        
        # Privacy & Performance
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "dom.security.https_only_mode" = true;
        "browser.cache.disk.enable" = false;
        "browser.sessionstore.privacy_level" = 2;
        
        # Disable bloat
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.snippets" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "extensions.pocket.enabled" = false;
        "extensions.pocket.showHome" = false;
        
        # Performance
        "gfx.webrender.all" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "dom.ipc.processCount" = 8;
        
        # Clean new tab page
        "browser.newtabpage.enabled" = false;
        "browser.startup.homepage" = "about:blank";
        
        # Disable telemetry
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.unified" = false;
        
        # Font rendering
        "gfx.font_rendering.cleartype_params.rendering_mode" = 5;
        "gfx.font_rendering.cleartype_params.cleartype_level" = 100;
        "gfx.font_rendering.cleartype_params.force_gdi_classic_for_families" = "";
        "gfx.font_rendering.cleartype_params.force_gdi_classic_max_size" = 6;
        "gfx.font_rendering.directwrite.use_gdi_table_loading" = false;
      };
      
      # Custom CSS for even cleaner look
      userChrome = ''
        /* Hide tab bar when only one tab */
        #tabbrowser-tabs {
          visibility: collapse !important;
        }
        
        /* Compact address bar */
        #urlbar {
          margin-top: 0 !important;
          margin-bottom: 0 !important;
          border: none !important;
        }
        
        /* Hide some toolbar buttons */
        #fxa-toolbar-menu-button,
        #PanelUI-button {
          display: none !important;
        }
      '';
    };
  };


  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}