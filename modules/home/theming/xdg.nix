{ config, ... }: {
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
      "text/html" = config.myDefaults.applications.browser.desktop;
      "x-scheme-handler/http" = config.myDefaults.applications.browser.desktop;
      "x-scheme-handler/https" = config.myDefaults.applications.browser.desktop;
      "x-scheme-handler/about" = config.myDefaults.applications.browser.desktop;
      "x-scheme-handler/unknown" = config.myDefaults.applications.browser.desktop;
      "application/pdf" = config.myDefaults.applications.pdfViewer.desktop;
      "text/plain" = config.myDefaults.applications.editor.desktop;
      "image/png" = config.myDefaults.applications.imageViewer.desktop;
      "image/jpeg" = config.myDefaults.applications.imageViewer.desktop;
      "image/jpg" = config.myDefaults.applications.imageViewer.desktop;
      "image/gif" = config.myDefaults.applications.imageViewer.desktop;
      "image/webp" = config.myDefaults.applications.imageViewer.desktop;
      "video/mp4" = config.myDefaults.applications.mediaPlayer.desktop;
      "video/x-matroska" = config.myDefaults.applications.mediaPlayer.desktop;
      "video/webm" = config.myDefaults.applications.mediaPlayer.desktop;
      "audio/mpeg" = config.myDefaults.applications.mediaPlayer.desktop;
      "audio/mp3" = config.myDefaults.applications.mediaPlayer.desktop;
      "audio/flac" = config.myDefaults.applications.mediaPlayer.desktop;
      "audio/ogg" = config.myDefaults.applications.mediaPlayer.desktop;
      "inode/directory" = config.myDefaults.applications.fileManager.desktop;

      # Terminal emulator for Thunar "Open Terminal Here"
      "application/x-terminal-emulator" = config.myDefaults.applications.terminal.desktop;
    };
  };
}
