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
    brightnessctl
    wlr-randr
    direnv

    # System Utilities
    libnotify
    yarn-berry

    # Fun Utilities
    neofetch
    fortune
    cowsay
    lolcat
  ];
}
