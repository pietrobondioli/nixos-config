{ config, pkgs, lib, ... }:

{
  # Configure XFCE helpers for Thunar (used by exo-open)
  xdg.configFile."xfce4/helpers.rc".text = ''
    TerminalEmulator=${config.myDefaults.applications.terminal.package}
    TerminalEmulatorDismissed=true
  '';

  # Configure Thunar custom actions for terminal (backup method)
  xdg.configFile."Thunar/uca.xml".text = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <actions>
      <action>
        <icon>utilities-terminal</icon>
        <name>Open Terminal Here</name>
        <unique-id>1234567890123456-1</unique-id>
        <command>KITTY_SCRATCH=1 ${config.myDefaults.applications.terminal.package} --class kitty-scratch %f</command>
        <description>Open terminal in current directory</description>
        <patterns>*</patterns>
        <startup-notify/>
        <directories/>
      </action>
    </actions>
  '';
}
