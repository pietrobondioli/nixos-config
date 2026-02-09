# zram swap configuration
# Compressed in-memory swap to prevent OOM freezes

{ ... }:

{
  zramSwap.enable = true;
  # memoryPercent defaults to 50, which is ~32GB on a 64GB system
}
