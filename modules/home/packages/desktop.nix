{ pkgs, ... }: {
  home.packages = with pkgs; [
    waybar
    slurp
    grim
    wtype
    swaybg
    swaylock
    swayidle
    firefox
    chromium
    vesktop
    teams-for-linux
    spotify
    mpv
    pwvucontrol
    copyq
    cliphist
    wl-clipboard
    satty
    gpu-screen-recorder
    wf-recorder
    zathura
  ];
}
