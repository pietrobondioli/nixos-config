{ pkgs, ... }: {
  services.swayidle = {
    enable = true;
    extraArgs = [ "-w" ];
    events = [
      { event = "before-sleep"; command = "${pkgs.swaylock}/bin/swaylock -f"; }
      { event = "lock"; command = "${pkgs.swaylock}/bin/swaylock -f"; }
    ];
    timeouts = [
      { timeout = 300; command = "${pkgs.swaylock}/bin/swaylock -f"; }
      { timeout = 600; command = "systemctl suspend"; resumeCommand = "${pkgs.swaylock}/bin/swaylock -f"; }
    ];
  };
}
