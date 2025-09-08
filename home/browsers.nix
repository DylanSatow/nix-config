{ config, pkgs, ... }: {
    programs.firefox = {
        enable = true;
        
        profiles.dylan = {
            isDefault = true;
            
            bookmarks.force = true;
            bookmarks.settings = [
                {
                    name = "Google Maps";
                    url = "https://maps.google.com";
                    keyword = "maps";
                }
                {
                    name = "Nix Home Manager Search";
                    url = "https://home-manager-options.extranix.com";
                    keyword = "hms";
                }
                {
                    name = "Google Drive";
                    url = "https://drive.google.com/drive/?pli=1";
                    keyword = "drv";
                }
                {
                    name = "Nix Packages Search";
                    url = "https://search.nixos.org/packages";
                    keyword = "nps";
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
                {
                    name = "Smithery";
                    url = "https://smithery.ai/";
                    keyword = "smth";
                }
                {
                    name = "Reddit";
                    url = "https://reddit.com";
                    keyword = "red";
                }
                {
                    name = "Canvas";
                    url = "https://courseworks2.columbia.edu/";
                    keyword = "canvas";
                }
                {
                    name = "Google Calendar";
                    url="https://calendar.google.com";
                    keyword = "gcal";
                }
                {
                    name = "Gmail";
                    url="https://mail.google.com";
                    keyword = "mail";
                }
            ];
            
            extensions = {
                packages = with pkgs; [
                ];
            };
            
            settings = {
                "signon.rememberSignons" = false;
                "signon.generation.enabled" = false;
                "signon.management.page.breach-alerts.enabled" = false;
                
                "browser.tabs.inTitlebar" = 1;
                "browser.uidensity" = 1;
                
                "privacy.trackingprotection.enabled" = true;
                "privacy.trackingprotection.socialtracking.enabled" = true;
                "dom.security.https_only_mode" = true;
                "browser.cache.disk.enable" = false;
                "browser.sessionstore.privacy_level" = 2;
                
                "browser.newtabpage.activity-stream.feeds.topsites" = false;
                "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
                "browser.newtabpage.activity-stream.feeds.snippets" = false;
                "browser.newtabpage.activity-stream.showSponsored" = false;
                "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
                "extensions.pocket.enabled" = false;
                "extensions.pocket.showHome" = false;
                
                "gfx.webrender.all" = true;
                "media.ffmpeg.vaapi.enabled" = true;
                "dom.ipc.processCount" = 8;
                
                "browser.newtabpage.enabled" = false;
                "browser.startup.homepage" = "about:blank";
                
                "datareporting.healthreport.uploadEnabled" = false;
                "datareporting.policy.dataSubmissionEnabled" = false;
                "toolkit.telemetry.enabled" = false;
                "toolkit.telemetry.unified" = false;
                
                "gfx.font_rendering.cleartype_params.rendering_mode" = 5;
                "gfx.font_rendering.cleartype_params.cleartype_level" = 100;
                "gfx.font_rendering.cleartype_params.force_gdi_classic_for_families" = "";
                "gfx.font_rendering.cleartype_params.force_gdi_classic_max_size" = 6;
                "gfx.font_rendering.directwrite.use_gdi_table_loading" = false;
                
                "browser.urlbar.suggest.history" = true;
                "browser.urlbar.suggest.bookmark" = true;
                "browser.urlbar.suggest.openpage" = true;
                "browser.urlbar.suggest.searches" = true;
                
                "dom.webnotifications.enabled" = false;
                "permissions.default.desktop-notification" = 2;
            };
            
            userChrome = ''
                #tabbrowser-tabs {
                    visibility: collapse !important;
                }
                
                #urlbar {
                    margin-top: 0 !important;
                    margin-bottom: 0 !important;
                    border: none !important;
                }
                
                #fxa-toolbar-menu-button,
                #PanelUI-button {
                    display: none !important;
                }
            '';
        };
    };
}
