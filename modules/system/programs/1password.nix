{ config, pkgs, lib, ... }:

{
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ config.myDefaults.user.name ];
  };

  # Enable browser integration
  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        zen
        zen-beta
        firefox
        firefox-nightly-bin
        chromium
        brave
      '';
      mode = "0755";
    };
  };

  # Ensure proper group membership for 1Password integration
  users.users.${config.myDefaults.user.name}.extraGroups = [ "onepassword" "onepassword-cli" ];
}
