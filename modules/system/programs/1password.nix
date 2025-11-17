{ config, pkgs, lib, ... }:

{
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "pietro" ];
  };

  # Enable browser integration
  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        zen
        zen-beta
        firefox
        chromium
        brave
      '';
      mode = "0755";
    };
  };

  # Ensure proper group membership for 1Password integration
  users.users.pietro.extraGroups = [ "onepassword" "onepassword-cli" ];
}
