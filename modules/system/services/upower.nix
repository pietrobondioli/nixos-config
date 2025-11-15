{ config, pkgs, lib, ... }:
{
  # Enable UPower daemon for power/battery info
  services.upower.enable = true;
  # Uncomment to tweak thresholds (use defaults if unsure)
  # services.upower.percentageLow = 20;
  # services.upower.percentageCritical = 10;
  # services.upower.percentageAction = 5;
  # services.upower.criticalPowerAction = "PowerOff"; # Or "Hibernate"/"HybridSleep"
}
