{ pkgs, ... }: {
  systemd.user.services.cliphist = {
    Unit = { Description = "Clipboard history daemon"; After = [ "graphical-session.target" ]; PartOf = [ "graphical-session.target" ]; };
    Install = { WantedBy = [ "graphical-session.target" ]; };
    Service = {
      ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist store";
      Restart = "on-failure";
      RestartSec = "1";
    };
  };
}
