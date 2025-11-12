{ config, pkgs, lib, ... }:

{
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true; # Automatically sets DOCKER_HOST for your user
  };
}
