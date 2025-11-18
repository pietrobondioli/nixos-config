{ ... }: {
  xdg.userDirs = { enable = true; createDirectories = true; };

  xdg.desktopEntries = {
    nvim-kitty = {
      name = "Neovim (Kitty)";
      genericName = "Text Editor";
      exec = "kitty nvim %F";
      terminal = false;
      categories = [ "Application" "TextEditor" ];
      mimeType = [ "text/plain" "text/*" ];
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
      "application/pdf" = "org.pwmt.zathura.desktop";
      "text/plain" = "nvim-kitty.desktop";
      "image/png" = "mpv.desktop";
      "image/jpeg" = "mpv.desktop";
      "image/jpg" = "mpv.desktop";
      "image/gif" = "mpv.desktop";
      "image/webp" = "mpv.desktop";
      "video/mp4" = "mpv.desktop";
      "video/x-matroska" = "mpv.desktop";
      "video/webm" = "mpv.desktop";
      "audio/mpeg" = "mpv.desktop";
      "audio/mp3" = "mpv.desktop";
      "audio/flac" = "mpv.desktop";
      "audio/ogg" = "mpv.desktop";
      "inode/directory" = "thunar.desktop";
    };
  };
}
