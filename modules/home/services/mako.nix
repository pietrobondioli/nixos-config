{ ... }: {
  services.mako = {
    enable = true;
    settings = {
      font = "JetBrainsMono Nerd Font 12";
      anchor = "top-right";
      background-color = "#1e1e2eFF";
      border-color = "#89b4faFF";
      border-size = 2;
      border-radius = 8;
      default-timeout = 8000;
      height = 120;
      width = 400;
      padding = "12";
      margin = "8";
      text-color = "#cdd6f4FF";
      progress-color = "#89b4faFF";
      icons = true;
    };
    extraConfig = ''
      [urgency=low]
      border-color=#45475a
      [urgency=high]
      border-color=#f38ba8
    '';
  };
}