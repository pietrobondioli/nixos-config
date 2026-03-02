{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Terminals
    alacritty
    foot

    # CLI Tools
    ripgrep
    fzf
    htop
    btop
    lsof
    brightnessctl
    wlr-randr
    direnv

    # System Utilities
    libnotify
    yarn-berry
    ncdu # interactive disk usage analyzer
    dua # fast disk usage analyzer (dua i for interactive mode)

    # Fun Utilities
    fastfetch
    fortune
    cowsay
    lolcat
  ];
}
