{ pkgs, ... }: {
  home.packages = with pkgs; [
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.hack
    nerd-fonts.meslo-lg
    nerd-fonts.symbols-only
  ];
}