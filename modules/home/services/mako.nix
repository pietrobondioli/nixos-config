{ ... }: {
  services.mako = {
    enable = true;
    settings = {
      font = "JetBrainsMono Nerd Font 12";
      anchor = "top-right";
      background-color = "#303446FF";
      border-color = "#8caaeeFF";
      border-size = 2;
      border-radius = 8;
      default-timeout = 8000;
      height = 120;
      width = 400;
      padding = "12";
      margin = "8";
      text-color = "#c6d0f5FF";
      progress-color = "#8caaeeFF";
      icons = true;
    };
    extraConfig = ''
      [urgency=low]
      border-color=#414559
      [urgency=high]
      border-color=#e78284
    '';
  };
}
