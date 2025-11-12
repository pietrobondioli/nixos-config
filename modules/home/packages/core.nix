{ pkgs, ... }: {
  home.packages = with pkgs; [
    alacritty
    foot
    ripgrep
    fzf
    htop
    direnv
    nixpkgs-fmt
    fortune
    cowsay
    lolcat
    neofetch
    btop
    brightnessctl
    wlr-randr
    libnotify
    yarn-berry
  ];
}