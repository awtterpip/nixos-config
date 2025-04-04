{pkgs, ...}: {
  fonts.fontconfig.enable = true;
  home.packages = [
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.twemoji-color-font
    pkgs.noto-fonts-emoji
  ];

  gtk = {
    enable = true;
    catppuccin.enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "lavender";
      };
    };
    # theme = {
    #   name = "Catppuccin-Mocha-Compact-Lavender-Dark";
    #   package = pkgs.catppuccin-gtk.override {
    #     accents = ["lavender"];
    #     size = "compact";
    #     # tweaks = [ "rimless" ];
    #     variant = "mocha";
    #   };
    # };
    cursorTheme = {
      name = "Nordzy-cursors";
      package = pkgs.nordzy-cursor-theme;
      size = 22;
    };
  };

  home.pointerCursor = {
    name = "Nordzy-cursors";
    package = pkgs.nordzy-cursor-theme;
    size = 22;
  };
}
