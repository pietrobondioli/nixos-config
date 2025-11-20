{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Monospace Fonts
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.hack
    nerd-fonts.meslo-lg

    # Symbol Fonts
    nerd-fonts.symbols-only
  ];
}
