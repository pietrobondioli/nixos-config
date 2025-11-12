{ config, pkgs, lib, ... }:

{
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add common libraries that might be needed
    stdenv.cc.cc.lib
    zlib
    # Add other libraries as needed
  ];
}
