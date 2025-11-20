{ lib, ... }:

{
  options.myDefaults = lib.mkOption {
    type = lib.types.submodule {
      options = {
        # User Identity
        user = lib.mkOption {
          type = lib.types.submodule {
            options = {
              name = lib.mkOption {
                type = lib.types.str;
                default = "pietro";
              };
              fullName = lib.mkOption {
                type = lib.types.str;
                default = "Pietro Bondioli";
              };
              email = lib.mkOption {
                type = lib.types.str;
                default = "email@pietrobondioli.com.br";
              };
              home = lib.mkOption {
                type = lib.types.str;
                default = "/home/pietro";
              };
            };
          };
          default = { };
        };

        # Paths
        paths = lib.mkOption {
          type = lib.types.submodule {
            options = {
              scripts = lib.mkOption {
                type = lib.types.str;
                default = "$HOME/scripts";
              };
              nixConfig = lib.mkOption {
                type = lib.types.str;
                default = "$HOME/personal/nixos-config";
              };
            };
          };
          default = { };
        };

        # Git Configuration
        git = lib.mkOption {
          type = lib.types.submodule {
            options = {
              baseUrl = lib.mkOption {
                type = lib.types.str;
                default = "https://github.com/pietrobondioli";
              };
              userName = lib.mkOption {
                type = lib.types.str;
                default = "Pietro Bondioli";
              };
              userEmail = lib.mkOption {
                type = lib.types.str;
                default = "email@pietrobondioli.com.br";
              };
              signingKey = lib.mkOption {
                type = lib.types.str;
                default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIBkYROpWTR4k2G7mzsT9I3SFhlL9A3wRPKHepcHmpIU";
              };
            };
          };
          default = { };
        };

        # Neovim Configuration
        nvim = lib.mkOption {
          type = lib.types.submodule {
            options = {
              repo = lib.mkOption {
                type = lib.types.str;
                default = "nvim-config";
              };
              localPath = lib.mkOption {
                type = lib.types.str;
                default = "personal/nvim-config";
              };
            };
          };
          default = { };
        };

        # System Settings
        system = lib.mkOption {
          type = lib.types.submodule {
            options = {
              hostname = lib.mkOption {
                type = lib.types.str;
                default = "pc";
              };
              timezone = lib.mkOption {
                type = lib.types.str;
                default = "America/Sao_Paulo";
              };
              keyboardLayout = lib.mkOption {
                type = lib.types.str;
                default = "us";
              };
              keyboardVariant = lib.mkOption {
                type = lib.types.str;
                default = "altgr-intl";
              };
            };
          };
          default = { };
        };

        # Location (for gammastep, etc.)
        location = lib.mkOption {
          type = lib.types.submodule {
            options = {
              latitude = lib.mkOption {
                type = lib.types.float;
                default = -23.5;
              };
              longitude = lib.mkOption {
                type = lib.types.float;
                default = -46.6;
              };
            };
          };
          default = { };
        };

        # Display Settings
        display = lib.mkOption {
          type = lib.types.submodule {
            options = {
              output = lib.mkOption {
                type = lib.types.str;
                default = "HDMI-A-1";
              };
              resolution = lib.mkOption {
                type = lib.types.str;
                default = "3840x2160@60.000";
              };
              scale = lib.mkOption {
                type = lib.types.float;
                default = 1.60;
              };
            };
          };
          default = { };
        };

        # Catppuccin Frappe Color Palette
        colors = lib.mkOption {
          type = lib.types.submodule {
            options = {
              # Base colors
              background = lib.mkOption {
                type = lib.types.str;
                default = "#303446";
              };
              foreground = lib.mkOption {
                type = lib.types.str;
                default = "#c6d0f5";
              };
              # Selection/highlights
              selection = lib.mkOption {
                type = lib.types.str;
                default = "#414559";
              };
              altBackground = lib.mkOption {
                type = lib.types.str;
                default = "#292c3c";
              };
              # Accent colors
              blue = lib.mkOption {
                type = lib.types.str;
                default = "#8caaee";
              };
              red = lib.mkOption {
                type = lib.types.str;
                default = "#e78284";
              };
              green = lib.mkOption {
                type = lib.types.str;
                default = "#a6d189";
              };
              yellow = lib.mkOption {
                type = lib.types.str;
                default = "#e5c890";
              };
              pink = lib.mkOption {
                type = lib.types.str;
                default = "#f4b8e4";
              };
              teal = lib.mkOption {
                type = lib.types.str;
                default = "#99d1db";
              };
              # Grays
              darkGray = lib.mkOption {
                type = lib.types.str;
                default = "#51576d";
              };
              # Semantic aliases
              accent = lib.mkOption {
                type = lib.types.str;
                default = "#8caaee";
              };
              error = lib.mkOption {
                type = lib.types.str;
                default = "#e78284";
              };
              success = lib.mkOption {
                type = lib.types.str;
                default = "#a6d189";
              };
              warning = lib.mkOption {
                type = lib.types.str;
                default = "#e5c890";
              };
            };
          };
          default = { };
        };

        # Typography
        fonts = lib.mkOption {
          type = lib.types.submodule {
            options = {
              primary = lib.mkOption {
                type = lib.types.str;
                default = "JetBrainsMono Nerd Font";
              };
              sizes = lib.mkOption {
                type = lib.types.submodule {
                  options = {
                    small = lib.mkOption {
                      type = lib.types.int;
                      default = 12;
                    };
                    medium = lib.mkOption {
                      type = lib.types.int;
                      default = 13;
                    };
                    large = lib.mkOption {
                      type = lib.types.int;
                      default = 14;
                    };
                  };
                };
                default = { };
              };
            };
          };
          default = { };
        };

        # Theme Settings
        theme = lib.mkOption {
          type = lib.types.submodule {
            options = {
              gtk = lib.mkOption {
                type = lib.types.str;
                default = "Adwaita-dark";
              };
              icons = lib.mkOption {
                type = lib.types.str;
                default = "Adwaita";
              };
              cursor = lib.mkOption {
                type = lib.types.submodule {
                  options = {
                    name = lib.mkOption {
                      type = lib.types.str;
                      default = "Bibata-Modern-Classic";
                    };
                    size = lib.mkOption {
                      type = lib.types.int;
                      default = 20;
                    };
                  };
                };
                default = { };
              };
            };
          };
          default = { };
        };

        # UI Design Tokens
        ui = lib.mkOption {
          type = lib.types.submodule {
            options = {
              borderRadius = lib.mkOption {
                type = lib.types.submodule {
                  options = {
                    large = lib.mkOption {
                      type = lib.types.int;
                      default = 12;
                    };
                    medium = lib.mkOption {
                      type = lib.types.int;
                      default = 8;
                    };
                    small = lib.mkOption {
                      type = lib.types.int;
                      default = 6;
                    };
                  };
                };
                default = { };
              };
              opacity = lib.mkOption {
                type = lib.types.submodule {
                  options = {
                    terminal = lib.mkOption {
                      type = lib.types.float;
                      default = 0.98;
                    };
                  };
                };
                default = { };
              };
            };
          };
          default = { };
        };

        # Default Applications
        applications = lib.mkOption {
          type = lib.types.submodule {
            options = {
              browser = lib.mkOption {
                type = lib.types.submodule {
                  options = {
                    desktop = lib.mkOption {
                      type = lib.types.str;
                      default = "firefox-nightly.desktop";
                    };
                    package = lib.mkOption {
                      type = lib.types.str;
                      default = "firefox-nightly";
                    };
                  };
                };
                default = { };
              };
              terminal = lib.mkOption {
                type = lib.types.submodule {
                  options = {
                    desktop = lib.mkOption {
                      type = lib.types.str;
                      default = "kitty.desktop";
                    };
                    package = lib.mkOption {
                      type = lib.types.str;
                      default = "kitty";
                    };
                  };
                };
                default = { };
              };
              fileManager = lib.mkOption {
                type = lib.types.submodule {
                  options = {
                    desktop = lib.mkOption {
                      type = lib.types.str;
                      default = "thunar.desktop";
                    };
                    package = lib.mkOption {
                      type = lib.types.str;
                      default = "thunar";
                    };
                  };
                };
                default = { };
              };
              editor = lib.mkOption {
                type = lib.types.submodule {
                  options = {
                    desktop = lib.mkOption {
                      type = lib.types.str;
                      default = "nvim-kitty.desktop";
                    };
                    command = lib.mkOption {
                      type = lib.types.str;
                      default = "nvim";
                    };
                  };
                };
                default = { };
              };
              mediaPlayer = lib.mkOption {
                type = lib.types.submodule {
                  options = {
                    desktop = lib.mkOption {
                      type = lib.types.str;
                      default = "mpv.desktop";
                    };
                    package = lib.mkOption {
                      type = lib.types.str;
                      default = "mpv";
                    };
                  };
                };
                default = { };
              };
              pdfViewer = lib.mkOption {
                type = lib.types.submodule {
                  options = {
                    desktop = lib.mkOption {
                      type = lib.types.str;
                      default = "org.pwmt.zathura.desktop";
                    };
                    package = lib.mkOption {
                      type = lib.types.str;
                      default = "zathura";
                    };
                  };
                };
                default = { };
              };
              shell = lib.mkOption {
                type = lib.types.str;
                default = "zsh";
              };
            };
          };
          default = { };
        };
      };
    };
    default = { };
    description = "Common default applications and values used across the system";
  };
}
