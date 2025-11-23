{ config, pkgs, lib, osConfig, ... }:

let
  laptopOutput = osConfig.myDefaults.display.output;
  # You can add more outputs here and create more complex profiles
  # run `niri msg outputs` to get the list of your outputs.
  externalOutput = "eDP-1";
in
{
  services.kanshi = {
    enable = true;
    package = pkgs.kanshi;
    profiles = {
      laptop = {
        outputs = [
          {
            criteria = laptopOutput;
            status = "enable";
          }
        ];
      };
      extended = {
        outputs = [
          {
            criteria = laptopOutput;
            status = "enable";
          }
          {
            criteria = externalOutput;
            status = "enable";
            position = "1920,0";
          }
        ];
      };
      cloned = {
        outputs = [
          {
            criteria = laptopOutput;
            status = "enable";
          }
          {
            criteria = externalOutput;
            status = "enable";
            position = "0,0";
          }
        ];
      };
    };
  };
}
