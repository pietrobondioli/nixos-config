{ config, pkgs, lib, ... }:

{
  # Enable GVFS (virtual filesystem)
  services.gvfs.enable = true;

  # Enable tumbler (thumbnail generation)
  services.tumbler.enable = true;
}
