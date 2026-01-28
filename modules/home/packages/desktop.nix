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
    wl-screenrec
    wf-recorder # fallback for NVIDIA VAAPI issues with wl-screenrec

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
    onlyoffice-desktopeditors

    # Architecture & Design
    # (pkgs.symlinkJoin {
    #   name = "FreeCAD";
    #   paths = [ pkgs.freecad-wayland ];
    #   buildInputs = [ pkgs.makeWrapper ];
    #   postBuild = ''
    #     wrapProgram $out/bin/FreeCAD \
    #       --set __GLX_VENDOR_LIBRARY_NAME mesa \
    #       --set __EGL_VENDOR_LIBRARY_FILENAMES ${pkgs.mesa}/share/glvnd/egl_vendor.d/50_mesa.json
    #   '';
    #   meta.mainProgram = "FreeCAD";
    # })
  ];
}
