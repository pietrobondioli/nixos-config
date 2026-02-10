{ config, pkgs, lib, ... }:

{
  # YubiKey U2F Authentication Configuration
  #
  # To enroll your YubiKey (required for first-time setup or if touch stops working):
  # 1. Plug in your YubiKey
  # 2. Run: nix-shell -p pam_u2f
  # 3. Run: mkdir -p ~/.config/Yubico
  # 4. Run: pamu2fcfg > ~/.config/Yubico/u2f_keys
  # 5. Touch your YubiKey when it blinks
  # 6. To add additional YubiKeys: pamu2fcfg -n >> ~/.config/Yubico/u2f_keys
  #
  # After enrollment, sudo will prompt you to touch your YubiKey for authentication.

  # YubiKey packages
  environment.systemPackages = with pkgs; [
    yubikey-manager # CLI tool for YubiKey management
    yubikey-personalization # For configuring YubiKey slots
    pam_u2f # For PAM U2F authentication
    yubioath-flutter # GUI tool
    libsecret # Secret management
  ];

  # Enable smartcard daemon for YubiKey
  services.pcscd.enable = true;

  # Add udev rules for U2F devices so user can access them
  services.udev.packages = [ pkgs.yubikey-personalization ];

  # PAM U2F authentication
  security.pam.u2f = {
    enable = true;
    control = "sufficient"; # Allows password OR YubiKey
    # control = "required";  # Use this if you want to ENFORCE YubiKey
    settings = {
      cue = true;
      cue_prompt = "🔑 Touch your Security Key";
    };
  };

  security.pam.services = {
    login.u2fAuth = false; # disable YubiKey for login, keep password only
    sudo.u2fAuth = true;
    # Disable YubiKey for display manager (ly)
    greetd.u2fAuth = false;
    ly.u2fAuth = false;
  };
}
