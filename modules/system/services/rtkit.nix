{ config, pkgs, lib, ... }:
{
  # Enable RealtimeKit (rtkit) for granting real-time priorities (needed by PipeWire)
  security.rtkit.enable = true;
}
