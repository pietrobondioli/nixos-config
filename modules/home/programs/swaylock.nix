{ config, lib, pkgs, ... }:

{
  programs.swaylock = {
    enable = true;
    settings = {
      color = config.myDefaults.colors.background + "dd";
      font = config.myDefaults.fonts.primary;
      font-size = config.myDefaults.fonts.sizes.large;

      fade-in = 0.2;
      effect-blur = "7x5";
      effect-vignette = "0.5:0.5";

      indicator = true;
      indicator-radius = 200;
      indicator-thickness = 20;

      ring-color = config.myDefaults.colors.altBackground;
      ring-ver-color = config.myDefaults.colors.blue;
      ring-wrong-color = config.myDefaults.colors.red;
      ring-clear-color = config.myDefaults.colors.green;

      key-hl-color = config.myDefaults.colors.blue;
      bs-hl-color = config.myDefaults.colors.red;
      separator-color = "00000000";

      inside-color = config.myDefaults.colors.altBackground;
      inside-ver-color = config.myDefaults.colors.blue;
      inside-wrong-color = config.myDefaults.colors.red;
      inside-clear-color = config.myDefaults.colors.green;

      text-color = config.myDefaults.colors.foreground;
      text-ver-color = config.myDefaults.colors.background;
      text-wrong-color = config.myDefaults.colors.background;
      text-clear-color = config.myDefaults.colors.background;
    };
  };
}
