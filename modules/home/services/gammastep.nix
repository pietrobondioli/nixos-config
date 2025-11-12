{ ... }: {
  services.gammastep = {
    enable = true;
    provider = "manual";
    latitude = -23.5;
    longitude = -46.6;
    temperature.day = 4500;
    temperature.night = 4500;
    settings.general.adjustment-method = "wayland";
  };
}