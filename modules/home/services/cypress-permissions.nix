{ pkgs, ... }: {
  systemd.user.services.fix-cypress-permissions = {
    Unit = {
      Description = "Fix Cypress permissions";
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c '${pkgs.findutils}/bin/find \"$HOME/.config/Cypress\" -type f -exec ${pkgs.coreutils}/bin/chmod u+w {} \\; 2>/dev/null || true'";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
