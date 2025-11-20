{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Window Manager & Status Bar
    waybar
    swaylock
    swayidle
    swaybg

    # Screenshot & Recording
    slurp
    grim
    satty
    gpu-screen-recorder
    wf-recorder

    # Clipboard & Input
    wtype
    wl-clipboard
    cliphist
    copyq

    # Media & Entertainment
    spotify
    vesktop
    teams-for-linux
    mpv
    prismlauncher

    # Audio Tools
    pwvucontrol

    # Document & Image Viewers
    zathura
    swayimg
  ];
}
