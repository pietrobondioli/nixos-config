{ config, pkgs, inputs, lib, ... }:

{
  programs.firefox = {
    enable = true;
    package = inputs.firefox-nightly.packages.${pkgs.system}.firefox-nightly-bin;
    policies = {
      Preferences = {
        "browser.tabs.splitView.enabled" = true;
      };
    };
  };
}
