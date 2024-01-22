{ config, pkgs, inputs, ... }: let 
  inherit (inputs) nixpkgs home-manager nur;
  inherit (config) allowUnfree;
  firefox-addons = pkgs.nur.repos.rycee.firefox-addons;
in 
{
  home-manager.users.gen = {
    home.packages = with pkgs; [
      firefox
    ];

    programs.firefox = {
      enable = true;
      profiles = {
        default = {
          id = 0;
          name = "default";
          settings = {
            "browser.disableResetPrompt" = true;
            "browser.download.panel.shown" = true;
            "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
            "browser.shell.checkDefaultBrowser" = false;
            "browser.shell.defaultBrowserCheckCount" = 1;
            "browser.uiCustomization.state" = ''{"placements":{"widget-overflow-fixed-list":[],"nav-bar":["back-button","forward-button","stop-reload-button","home-button","urlbar-container","downloads-button","library-button","ublock0_raymondhill_net-browser-action","_testpilot-containers-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button","alltabs-button"],"PersonalToolbar":["import-button","personal-bookmarks"]},"seen":["save-to-pocket-button","developer-button","ublock0_raymondhill_net-browser-action","_testpilot-containers-browser-action"],"dirtyAreaCache":["nav-bar","PersonalToolbar","toolbar-menubar","TabsToolbar","widget-overflow-fixed-list"],"currentVersion":18,"newElementCount":4}'';
            "dom.security.https_only_mode" = true;
            "identity.fxaccounts.enabled" = false;
            "privacy.trackingprotection.enabled" = true;
            "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
          };
          extensions = with firefox-addons; [
            ublock-origin
            bitwarden
            firenvim
            darkreader
            localcdn
            sponsorblock
            unpaywall
          ];
        };
      };
    };
  };
}
