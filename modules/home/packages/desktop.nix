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
    wl-screenrec # using wl-screenrec instead of wf-recorder due to FFmpeg bug in wf-recorder 0.5.0

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
