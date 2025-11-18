{ pkgs, ... }: {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.override { niriSupport = true; };
  };

  home.packages = with pkgs; [
    playerctl # Media player control (MPRIS)
    brightnessctl # Brightness control
    pavucontrol # PulseAudio volume control GUI
  ];
}
