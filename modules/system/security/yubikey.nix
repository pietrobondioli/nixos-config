{ config, pkgs, lib, ... }:

{
  # Enable smartcard daemon for YubiKey
  services.pcscd.enable = true;

  # Enable U2F support (for 2FA in browsers, etc.)
  services.udev.packages = [ pkgs.yubikey-personalization ];

  # PAM U2F authentication
  security.pam.u2f = {
    enable = true;
    control = "sufficient";  # Allows password OR YubiKey
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
