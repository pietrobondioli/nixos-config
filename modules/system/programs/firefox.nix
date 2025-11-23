{ config, pkgs, inputs, lib, ... }:

{
  programs.firefox = {
    enable = true;
    package = inputs.firefox-nightly.packages.${pkgs.system}.firefox-nightly-bin;
    policies = {
      "FirefoxHome" = {
        "Search" = true;
        "TopSites" = false;
        "SponsoredTopSites" = false;
        "Highlights" = false;
        "Pocket" = false;
        "SponsoredPocket" = false;
        "Snippets" = false;
        "Locked" = false;
      };
      "DisplayMenuBar" = "always";
      "SearchEngines" = {
        "Default" = "Google";
      };
      Preferences = {
        "sidebar.revamp" = true;
        "sidebar.verticalTabs" = true;
        "browser.toolbars.bookmarks.visibility" = "always";
        "browser.tabs.splitView.enabled" = true;
      };
    };
  };

  # Wrapper to provide 'firefox' command for nightly
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "firefox" ''
      exec ${inputs.firefox-nightly.packages.${pkgs.system}.firefox-nightly-bin}/bin/firefox-nightly "$@"
    '')
  ];
}
