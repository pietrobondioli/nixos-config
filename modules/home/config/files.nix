{ config, lib, ... }:
let
  userHome = config.myDefaults.user.home;
  ensureDirectories = config.myDefaults.user.ensureDirectories;
  mkdirCommands = lib.concatMapStringsSep "\n"
    (dir: "$DRY_RUN_CMD mkdir -p ${userHome}/${dir}")
    ensureDirectories;
in
{
  # Always copy dotfiles for all hosts
  xdg.configFile."niri" = { source = ../../../dotfiles/niri; recursive = true; };
  xdg.configFile."zellij" = { source = ../../../dotfiles/zellij; recursive = true; };
  xdg.configFile."wallpapers" = { source = ../../../dotfiles/wallpapers; recursive = true; };
  xdg.configFile."satty" = { source = ../../../dotfiles/satty; recursive = true; };
  home.file."scripts" = { source = ../../../dotfiles/scripts; recursive = true; };

  # Ensure required directories always exist on new machines
  home.activation.ensureDirectories = lib.mkIf (ensureDirectories != [ ]) (
    lib.hm.dag.entryAfter [ "writeBoundary" ] mkdirCommands
  );
}
