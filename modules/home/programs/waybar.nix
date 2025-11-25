{ config, pkgs, osConfig, ... }: {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.override { niriSupport = true; };

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 34;
        spacing = 2;

        output = osConfig.myDefaults.display.output;

        modules-left = [ "niri/workspaces" "niri/window" ];
        modules-center = [ "clock" ];
        modules-right = [
          "mpris"
          "idle_inhibitor"
          "wireplumber"
          "network"
          "memory"
          "cpu"
          "temperature"
        ] ++ (if osConfig.myDefaults.system.hostname != "laptop" then [ "custom/gpu-temp" ] else [ ])
        ++ (if osConfig.myDefaults.system.hostname == "laptop" then [ "battery" "backlight" ] else [ ]) ++ [
          "keyboard-state"
          "tray"
          "custom/power"
        ];

        "niri/workspaces" = {
          format = "{icon} {value}";
          format-icons = {
            "1" = "💻";
            "2" = "🛠️";
            "3" = "🌐";
            "4" = "💬";
            "5" = "🎵";
            "6" = "🎮";
            active = "⚡";
            default = "";
          };
        };

        "niri/window" = {
          format = "{}";
          max-length = 50;
          separate-outputs = true;
        };

        clock = {
          format = "{:%a %b %d  %H:%M:%S}";
          format-alt = "{:%Y-%m-%d  %H:%M}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          interval = 1;
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#f5e0dc'><b>{}</b></span>";
              days = "<span color='#cdd6f4'><b>{}</b></span>";
              weeks = "<span color='#94e2d5'><b>W{}</b></span>";
              weekdays = "<span color='#f9e2af'><b>{}</b></span>";
              today = "<span color='#f38ba8'><b><u>{}</u></b></span>";
            };
          };
        };

        wireplumber = {
          format = "{icon} {volume}%";
          format-muted = " muted";
          format-icons = [ "" "" "" ];
          on-click = "pavucontrol";
          scroll-step = 5;
        };

        network = {
          format-wifi = " {essid} ({signalStrength}%)";
          format-ethernet = " {ifname}";
          format-disconnected = " Disconnected";
          tooltip-format = "{ifname}: {ipaddr}/{cidr}";
          tooltip-format-wifi = "{essid} ({signalStrength}%)\n{ifname}: {ipaddr}/{cidr}";
          on-click = "kitty --class nmtui -e nmtui";
          interval = 10;
        };

        memory = {
          format = " {}%";
          tooltip-format = "RAM: {used:0.1f}G / {total:0.1f}G";
          interval = 30;
          states = {
            critical = 90;
          };
        };

        cpu = {
          format = " {usage}%";
          tooltip = true;
          interval = 10;
          states = {
            critical = 80;
          };
        };

        temperature = {
          hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
          critical-threshold = 80;
          format = " {temperatureC}°C";
          format-critical = " {temperatureC}°C";
          interval = 10;
        };
      } // (if osConfig.myDefaults.system.hostname != "laptop" then {
        "custom/gpu-temp" = {
          exec = "nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader";
          format = " {}°C";
          interval = 10;
          return-type = "";
        };
      } else { }) // (if osConfig.myDefaults.system.hostname == "laptop" then {
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "🔋 {capacity}%";
          format-charging = "⚡ {capacity}%";
          format-plugged = "🔌 {capacity}%";
          format-alt = "🔋 {time}";
          tooltip-format = "{timeTo}\n{capacity}% - {power}W";
        };

        backlight = {
          format = "{icon} {percent}%";
          format-icons = [ "" "" "" "" "" "" "" "" "" ];
          on-scroll-up = "brightnessctl set 5%+";
          on-scroll-down = "brightnessctl set 5%-";
          tooltip-format = "Brightness: {percent}%";
        };
      } else { }) // {

        "keyboard-state" = {
          numlock = true;
          capslock = true;
          format = {
            numlock = " Num {icon} ";
            capslock = " Caps {icon} ";
          };
          format-icons = {
            locked = "🔒";
            unlocked = "🔓";
          };
        };

        tray = {
          icon-size = 16;
          spacing = 10;
        };

        mpris = {
          format = "{player_icon} {dynamic}";
          format-paused = "{status_icon} <i>{dynamic}</i>";
          player-icons = {
            default = "▶";
            mpv = "🎵";
            spotify = "";
          };
          status-icons = {
            paused = "⏸";
          };
          dynamic-order = [ "title" "artist" ];
          dynamic-separator = " - ";
          max-length = 30;
          on-click = "playerctl play-pause";
          on-click-right = "playerctl next";
          on-scroll-up = "playerctl previous";
          on-scroll-down = "playerctl next";
        };

        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "󰅶";
            deactivated = "󰾪";
          };
          tooltip-format-activated = "Idle inhibitor: ON";
          tooltip-format-deactivated = "Idle inhibitor: OFF";
        };

        "custom/power" = {
          format = "⏻";
          on-click = "$HOME/scripts/rofi-power-menu";
          tooltip = false;
        };
      };
    };

    style = ''
      /* Global styles */
      * {
          border: none;
          border-radius: 0;
          font-family: "JetBrainsMono Nerd Font", monospace;
          font-size: 13px;
          min-height: 0;
      }

      window#waybar {
          background: rgba(48, 52, 70, 0.95);
          color: #c6d0f5;
      }

      tooltip {
          background: rgba(48, 52, 70, 0.95);
          border: 1px solid rgba(140, 170, 238, 0.3);
          border-radius: 8px;
      }

      tooltip label {
          color: #c6d0f5;
      }

      /* Workspaces */
      #workspaces {
          padding: 0 5px;
      }

      #workspaces button {
          padding: 0 8px;
          color: #737994;
          background: transparent;
          transition: all 0.3s ease;
      }

      #workspaces button.active {
          color: #8caaee;
          background: rgba(140, 170, 238, 0.15);
      }

      #workspaces button:hover {
          background: rgba(198, 208, 245, 0.1);
          color: #c6d0f5;
      }

      #workspaces button.urgent {
          color: #e78284;
          background: rgba(231, 130, 132, 0.15);
      }

      #workspaces button.empty {
          background-color: transparent;
          color: #51576d;
          opacity: 0.5;
      }

      /* Ensure all workspace buttons have proper color */
      #workspaces button * {
          color: inherit;
      }

      /* Window title */
      #window {
          padding: 0 12px;
          color: #a5adce;
          font-weight: 500;
      }

      /* Clock */
      #clock {
          padding: 0 16px;
          color: #f2d5cf;
          font-weight: 600;
      }

      /* Common module styling */
      #mpris,
      #idle_inhibitor,
      #wireplumber,
      #backlight,
      #network,
      #memory,
      #cpu,
      #temperature,
      #custom-gpu-temp,
      #battery,
      #keyboard-state,
      #tray,
      #custom-power {
          padding: 0 12px;
      }

      /* Module colors */
      #mpris {
          color: #ca9ee6;
      }

      #mpris.paused {
          color: #737994;
          font-style: italic;
      }

      #idle_inhibitor {
          color: #e5c890;
      }

      #idle_inhibitor.activated {
          color: #e78284;
      }

      #wireplumber {
          color: #8caaee;
      }

      #wireplumber.muted {
          color: #737994;
      }

      #backlight {
          color: #ef9f76;
      }

      #network {
          color: #a6d189;
      }

      #network.disconnected {
          color: #e78284;
      }

      #memory {
          color: #e5c890;
      }

      #memory.critical {
          color: #e78284;
          animation: blink 1s linear infinite;
      }

      #cpu {
          color: #ef9f76;
      }

      #cpu.critical {
          color: #e78284;
          animation: blink 1s linear infinite;
      }

      #temperature {
          color: #e78284;
      }

      #temperature.critical {
          color: #e78284;
          animation: blink 1s linear infinite;
      }

      #custom-gpu-temp {
          color: #99d1db;
      }

      #battery {
          color: #a6d189;
      }

      #battery.charging {
          color: #a6e3a1;
      }

      #battery.warning:not(.charging) {
          color: #f9e2af;
      }

      #battery.critical:not(.charging) {
          color: #e78284;
          animation: blink 1s linear infinite;
      }

      #backlight {
          color: #ef9f76;
      }

      #custom-power {
          color: #e78284;
          font-size: 16px;
          transition: all 0.3s ease;
      }

      #custom-power:hover {
          color: #f4b8e4;
          background: rgba(231, 130, 132, 0.15);
      }

      #keyboard-state {
          color: #ca9ee6;
          padding: 0 8px;
      }

      #keyboard-state > label {
          padding: 0 4px;
      }

      #keyboard-state > label.locked {
          background: rgba(202, 158, 230, 0.15);
      }

      @keyframes blink {
          to {
              opacity: 0.5;
          }
      }

      #tray {
          padding: 0 8px;
      }

      #tray > .passive {
          -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
          -gtk-icon-effect: highlight;
      }
    '';
  };

  home.packages = with pkgs; [
    playerctl # Media player control (MPRIS)
    brightnessctl # Brightness control
    pavucontrol # PulseAudio volume control GUI
  ];
}
