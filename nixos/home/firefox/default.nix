{ pkgs, lib, ... }:

# most of config copied from https://github.com/Misterio77/nix-config/blob/99c84bdaf91f799b441274046ee1f640d1ccd3dd/home/gabriel/features/desktop/common/firefox.nix
{
  programs.firefox = {
    enable = true;

    profiles.default = {
      isDefault = true;
      search = {
        default = "DuckDuckGo";
        force = true;
      };
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        darkreader
        vimium
        sidebery
        firefox-color
      ];

      settings = {
        # Disable irritating first-run stuff
        "browser.disableResetPrompt" = true;
        "browser.download.panel.shown" = true;
        "browser.feeds.showFirstRunUI" = false;
        "browser.messaging-system.whatsNewPanel.enabled" = false;
        "browser.rights.3.shown" = true;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;
        "browser.startup.homepage_override.mstone" = "ignore";
        "browser.uitour.enabled" = false;
        "startup.homepage_override_url" = "";
        "trailhead.firstrun.didSeeAboutWelcome" = true;
        "browser.bookmarks.restore_default_bookmarks" = false;
        "browser.bookmarks.addedImportButton" = true;

        # Don't ask for download dir
        "browser.download.useDownloadDir" = false;

        # Disable crappy home activity stream page
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" = false;
        "browser.newtabpage.blocked" = lib.genAttrs [
          "26UbzFJ7qT9/4DhodHKA1Q==" # Youtube
          "4gPpjkxgZzXPVtuEoAL9Ig==" # Facebook
          "eV8/WsSLxHadrTL1gAxhug==" # Wikipedia
          "gLv0ja2RYVgxKdp0I5qwvA==" # Reddit
          "K00ILysCaEq8+bEqV/3nuw==" # Amazon
          "T9nJot5PurhJSy8n038xGA==" # Twitter
        ] (_: 1);

        # Disable "save password" prompt
        "signon.rememberSignons" = false;
        # Harden
        "privacy.trackingprotection.enabled" = true;
        "dom.security.https_only_mode" = true;

        # Styling
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };

      userChrome = ''
        #TabsToolbar{ visibility: collapse !important }
      '';
    };
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "firefox.desktop" ];
    "text/xml" = [ "firefox.desktop" ];
    "x-scheme-handler/http" = [ "firefox.desktop" ];
    "x-scheme-handler/https" = [ "firefox.desktop" ];
  };
}
