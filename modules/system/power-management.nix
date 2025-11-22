{ config, lib, pkgs, ... }:

let
  cfg = config.myDefaults.power.battery.charge;
in
{
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      START_CHARGE_THRESH_BAT0 = cfg.startThreshold;
      STOP_CHARGE_THRESH_BAT0 = cfg.stopThreshold;
    };
  };
}
