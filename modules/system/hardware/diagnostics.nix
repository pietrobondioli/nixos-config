{ pkgs, ... }: {
  # Adds memtest86+ as a boot entry in systemd-boot.
  # To use: reboot and select "memtest86+" from the boot menu.
  boot.loader.systemd-boot.memtest86.enable = true;

  # SMART monitoring daemon - auto-detects drives and logs errors to journald
  services.smartd = {
    enable = true;
    autodetect = true;
  };

  environment.systemPackages = with pkgs; [
    smartmontools # Manual SMART queries: `smartctl -a /dev/sda`
    memtester # Userspace RAM test: `sudo memtester 1G 1`
    lm_sensors # CPU/board temps: `sensors`
    stress-ng # Stress test CPU/RAM: `stress-ng --vm 2 --vm-bytes 1G`
  ];
}
