{ lib }:

# Type definitions for myDefaults configuration
# This separates the structure from the actual values
lib.types.submodule {
  options = {
    user = lib.mkOption {
      type = lib.types.submodule {
        options = {
          name = lib.mkOption { type = lib.types.str; };
          fullName = lib.mkOption { type = lib.types.str; };
          email = lib.mkOption { type = lib.types.str; };
          home = lib.mkOption { type = lib.types.str; };
        };
      };
      default = { };
    };

    paths = lib.mkOption {
      type = lib.types.submodule {
        options = {
          scripts = lib.mkOption { type = lib.types.str; };
          nixConfig = lib.mkOption { type = lib.types.str; };
          nvimConfig = lib.mkOption { type = lib.types.str; };
        };
      };
      default = { };
    };

    git = lib.mkOption {
      type = lib.types.submodule {
        options = {
          baseUrl = lib.mkOption { type = lib.types.str; };
          userName = lib.mkOption { type = lib.types.str; };
          userEmail = lib.mkOption { type = lib.types.str; };
          signingKey = lib.mkOption { type = lib.types.str; };
        };
      };
      default = { };
    };

    nvim = lib.mkOption {
      type = lib.types.submodule {
        options = {
          repo = lib.mkOption { type = lib.types.str; };
          localPath = lib.mkOption { type = lib.types.str; };
        };
      };
      default = { };
    };

    system = lib.mkOption {
      type = lib.types.submodule {
        options = {
          hostname = lib.mkOption { type = lib.types.str; };
          timezone = lib.mkOption { type = lib.types.str; };
          keyboardLayout = lib.mkOption { type = lib.types.str; };
          keyboardVariant = lib.mkOption { type = lib.types.str; };
        };
      };
      default = { };
    };

    location = lib.mkOption {
      type = lib.types.submodule {
        options = {
          latitude = lib.mkOption { type = lib.types.float; };
          longitude = lib.mkOption { type = lib.types.float; };
        };
      };
      default = { };
    };

    display = lib.mkOption {
      type = lib.types.submodule {
        options = {
          output = lib.mkOption { type = lib.types.str; };
          resolution = lib.mkOption { type = lib.types.str; };
          scale = lib.mkOption { type = lib.types.float; };
        };
      };
      default = { };
    };

    colors = lib.mkOption {
      type = lib.types.submodule {
        options = {
          background = lib.mkOption { type = lib.types.str; };
          foreground = lib.mkOption { type = lib.types.str; };
          selection = lib.mkOption { type = lib.types.str; };
          altBackground = lib.mkOption { type = lib.types.str; };
          blue = lib.mkOption { type = lib.types.str; };
          red = lib.mkOption { type = lib.types.str; };
          green = lib.mkOption { type = lib.types.str; };
          yellow = lib.mkOption { type = lib.types.str; };
          pink = lib.mkOption { type = lib.types.str; };
          teal = lib.mkOption { type = lib.types.str; };
          darkGray = lib.mkOption { type = lib.types.str; };
          accent = lib.mkOption { type = lib.types.str; };
          error = lib.mkOption { type = lib.types.str; };
          success = lib.mkOption { type = lib.types.str; };
          warning = lib.mkOption { type = lib.types.str; };
        };
      };
      default = { };
    };

    fonts = lib.mkOption {
      type = lib.types.submodule {
        options = {
          primary = lib.mkOption { type = lib.types.str; };
          sizes = lib.mkOption {
            type = lib.types.submodule {
              options = {
                small = lib.mkOption { type = lib.types.int; };
                medium = lib.mkOption { type = lib.types.int; };
                large = lib.mkOption { type = lib.types.int; };
              };
            };
            default = { };
          };
        };
      };
      default = { };
    };

    theme = lib.mkOption {
      type = lib.types.submodule {
        options = {
          gtk = lib.mkOption { type = lib.types.str; };
          icons = lib.mkOption { type = lib.types.str; };
          cursor = lib.mkOption {
            type = lib.types.submodule {
              options = {
                name = lib.mkOption { type = lib.types.str; };
                size = lib.mkOption { type = lib.types.int; };
              };
            };
            default = { };
          };
        };
      };
      default = { };
    };

    ui = lib.mkOption {
      type = lib.types.submodule {
        options = {
          borderRadius = lib.mkOption {
            type = lib.types.submodule {
              options = {
                large = lib.mkOption { type = lib.types.int; };
                medium = lib.mkOption { type = lib.types.int; };
                small = lib.mkOption { type = lib.types.int; };
              };
            };
            default = { };
          };
          opacity = lib.mkOption {
            type = lib.types.submodule {
              options = {
                terminal = lib.mkOption { type = lib.types.float; };
              };
            };
            default = { };
          };
        };
      };
      default = { };
    };

    applications = lib.mkOption {
      type = lib.types.submodule {
        options = {
          browser = lib.mkOption {
            type = lib.types.submodule {
              options = {
                desktop = lib.mkOption { type = lib.types.str; };
                package = lib.mkOption { type = lib.types.str; };
              };
            };
            default = { };
          };
          terminal = lib.mkOption {
            type = lib.types.submodule {
              options = {
                desktop = lib.mkOption { type = lib.types.str; };
                package = lib.mkOption { type = lib.types.str; };
              };
            };
            default = { };
          };
          fileManager = lib.mkOption {
            type = lib.types.submodule {
              options = {
                desktop = lib.mkOption { type = lib.types.str; };
                package = lib.mkOption { type = lib.types.str; };
              };
            };
            default = { };
          };
          editor = lib.mkOption {
            type = lib.types.submodule {
              options = {
                desktop = lib.mkOption { type = lib.types.str; };
                command = lib.mkOption { type = lib.types.str; };
              };
            };
            default = { };
          };
          imageViewer = lib.mkOption {
            type = lib.types.submodule {
              options = {
                desktop = lib.mkOption { type = lib.types.str; };
                package = lib.mkOption { type = lib.types.str; };
              };
            };
            default = { };
          };
          mediaPlayer = lib.mkOption {
            type = lib.types.submodule {
              options = {
                desktop = lib.mkOption { type = lib.types.str; };
                package = lib.mkOption { type = lib.types.str; };
              };
            };
            default = { };
          };
          pdfViewer = lib.mkOption {
            type = lib.types.submodule {
              options = {
                desktop = lib.mkOption { type = lib.types.str; };
                package = lib.mkOption { type = lib.types.str; };
              };
            };
            default = { };
          };
          shell = lib.mkOption { type = lib.types.str; };
        };
      };
      default = { };
    };
  };
}
