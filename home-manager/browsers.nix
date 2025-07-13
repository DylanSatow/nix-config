{ config, pkgs, ... }: {
  programs.firefox = {
    enable = true;
    
    profiles.dylan = {
      isDefault = true;
      
      # Bookmarks
      bookmarks.force = true;
      bookmarks.settings = [
        {
          name = "Google Maps";
          url = "https://maps.google.com";
          keyword = "maps";
        }
        {
          name = "Nix Home Manager";
          url = "https://nix-community.github.io/home-manager/";
          keyword = "hm";
        }
        {
          name = "Nix Darwin Manual";
          url = "https://nix-darwin.github.io/nix-darwin/manual/";
          keyword = "darwin";
        }
        {
          name = "GitHub";
          url = "https://github.com";
          keyword = "gh";
        }
        {
          name = "YouTube";
          url = "https://youtube.com";
          keyword = "yt";
        }
      ];
      
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
        
        # URL bar suggestions - only show bookmarks, not history
        "browser.urlbar.suggest.history" = false;
        "browser.urlbar.suggest.bookmark" = true;
        "browser.urlbar.suggest.openpage" = false;
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
}