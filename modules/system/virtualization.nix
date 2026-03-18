{ config, pkgs, lib, ... }:

{
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true; # Automatically sets DOCKER_HOST for your user
  };

  # Allow containers to reach the host via the slirp4netns gateway (10.0.2.2).
  # Without this, rootlesskit's --disable-host-loopback blocks 10.0.2.2, making
  # host.docker.internal unreachable. With it, 10.0.2.2:PORT maps to 127.0.0.1:PORT
  # on the host — including kubectl port-forward listeners.
  systemd.user.services.docker.environment.DOCKERD_ROOTLESS_ROOTLESSKIT_DISABLE_HOST_LOOPBACK = "false";

  # Tell the rootless Docker daemon that the host-gateway token should resolve to
  # 10.0.2.2 (the slirp4netns gateway) instead of the bridge IP (172.17.0.1),
  # which is unreachable from containers in rootless mode.
  # This makes `extra_hosts: ["host.docker.internal:host-gateway"]` in compose files
  # work correctly without hardcoding any IPs in the compose file itself.
  # NOTE: virtualisation.docker.daemon.settings writes into the Nix store config file
  # that dockerd is actually launched with (--config-file=/nix/store/...); using
  # xdg.configFile for ~/.config/docker/daemon.json has no effect because the NixOS
  # module hard-codes the config-file path to the store.
  virtualisation.docker.rootless.daemon.settings = {
    "host-gateway-ip" = "10.0.2.2";
  };
}
