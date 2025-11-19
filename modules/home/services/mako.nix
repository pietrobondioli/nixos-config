{ config, ... }:
let
  c = config.myDefaults.colors;
  fonts = config.myDefaults.fonts;
  ui = config.myDefaults.ui;
in
{
  services.mako = {
    enable = true;
    settings = {
      font = "${fonts.primary} ${toString fonts.sizes.small}";
      anchor = "top-right";
      background-color = "${c.background}FF";
      border-color = "${c.blue}FF";
      border-size = 2;
      border-radius = ui.borderRadius.medium;
      default-timeout = 10000;
      ignore-timeout = true;
      height = 120;
      width = 400;
      padding = "12";
      margin = "8";
      text-color = "${c.foreground}FF";
      progress-color = "${c.blue}FF";
      icons = true;
    };
    extraConfig = ''
      [urgency=low]
      border-color=${c.selection}
      [urgency=high]
      border-color=${c.red}
    '';
  };
}
