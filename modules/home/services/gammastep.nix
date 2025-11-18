{ config, ... }: {
  services.gammastep = {
    enable = true;
    provider = "manual";
    latitude = config.myDefaults.location.latitude;
    longitude = config.myDefaults.location.longitude;
    temperature.day = 4500;
    temperature.night = 4500;
    settings.general.adjustment-method = "wayland";
  };
}
