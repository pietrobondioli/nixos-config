{ config, pkgs, ... }: {
  programs.rofi = {
    enable = true;
    plugins = with pkgs; [ rofi-emoji ];
    package = pkgs.rofi;
    font = "JetBrainsMono Nerd Font 12";
    terminal = "kitty";
    extraConfig = {
      modi = "drun,run,window,ssh";
      show-icons = true;
      icon-theme = "Adwaita";
      display-drun = " Apps";
      display-run = " Run";
      display-window = "󰖯 Windows";
      display-ssh = " SSH";
      drun-display-format = "{name}";
      window-format = "{w} · {c} · {t}";
      width = 35;
      lines = 10;
      columns = 1;
      sort = true;
      sorting-method = "fzf";
      matching = "fuzzy";
      scroll-method = 0;
      disable-history = false;
      cycle = true;
      hide-scrollbar = true;
      fixed-num-lines = true;
      sidebar-mode = false;
      hover-select = true;
      me-select-entry = "";
      me-accept-entry = "MousePrimary";
    };
    theme = let inherit (config.lib.formats.rasi) mkLiteral; in {
      "*" = { bg = mkLiteral "#303446ff"; bg-alt = mkLiteral "#292c3cff"; bg-selected = mkLiteral "#414559ff"; fg = mkLiteral "#c6d0f5ff"; fg-alt = mkLiteral "#838ba7ff"; border = mkLiteral "#8caaeeff"; border-alt = mkLiteral "#babbf1ff"; background-color = mkLiteral "transparent"; text-color = mkLiteral "@fg"; font = "JetBrainsMono Nerd Font 12"; margin = 0; padding = 0; spacing = 0; };
      window = { location = mkLiteral "center"; width = 640; border-radius = 12; background-color = mkLiteral "@bg"; border = 2; border-color = mkLiteral "@border"; };
      mainbox = { padding = 12; background-color = mkLiteral "inherit"; };
      inputbar = { padding = mkLiteral "12px 16px"; spacing = 12; background-color = mkLiteral "@bg-alt"; border-radius = 8; border = 0; children = map mkLiteral [ "prompt" "entry" ]; };
      prompt = { text-color = mkLiteral "@border"; font = "JetBrainsMono Nerd Font Bold 13"; };
      entry = { placeholder = "Search..."; placeholder-color = mkLiteral "@fg-alt"; text-color = mkLiteral "@fg"; cursor = mkLiteral "text"; };
      message = { margin = mkLiteral "12px 0 0"; border-radius = 8; border-color = mkLiteral "@border"; background-color = mkLiteral "@bg-alt"; };
      textbox = { padding = 12; background-color = mkLiteral "inherit"; text-color = mkLiteral "@fg"; };
      listview = { margin = mkLiteral "12px 0 0"; columns = 1; lines = 8; fixed-height = false; background-color = mkLiteral "transparent"; scrollbar = false; spacing = 4; cycle = true; dynamic = true; };
      element = { padding = mkLiteral "10px 14px"; spacing = 12; border-radius = 6; background-color = mkLiteral "transparent"; text-color = mkLiteral "@fg"; cursor = mkLiteral "pointer"; };
      "element normal.normal" = { background-color = mkLiteral "inherit"; text-color = mkLiteral "inherit"; };
      "element normal.urgent" = { background-color = mkLiteral "#e78284ff"; text-color = mkLiteral "@bg"; };
      "element normal.active" = { background-color = mkLiteral "#a6d189ff"; text-color = mkLiteral "@bg"; };
      "element selected.normal" = { background-color = mkLiteral "@bg-selected"; text-color = mkLiteral "@border"; };
      "element selected.urgent" = { background-color = mkLiteral "#e78284ff"; text-color = mkLiteral "@bg"; };
      "element selected.active" = { background-color = mkLiteral "#a6d189ff"; text-color = mkLiteral "@bg"; };
      "element alternate.normal" = { background-color = mkLiteral "inherit"; text-color = mkLiteral "inherit"; };
      "element-icon" = { size = 28; cursor = mkLiteral "inherit"; background-color = mkLiteral "transparent"; text-color = mkLiteral "inherit"; };
      "element-text" = { vertical-align = mkLiteral "0.5"; cursor = mkLiteral "inherit"; background-color = mkLiteral "transparent"; text-color = mkLiteral "inherit"; };
    };
  };
}
