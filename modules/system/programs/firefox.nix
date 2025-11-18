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

  # Wrapper to provide 'firefox' command for nightly
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "firefox" ''
      exec ${inputs.firefox-nightly.packages.${pkgs.system}.firefox-nightly-bin}/bin/firefox-nightly "$@"
    '')
  ];
}
