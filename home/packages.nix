{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    bitwise # cli tool for bit / hex manipulation
    eza # ls replacement
    entr # perform action when file change
    file # Show file information
    fzf # fuzzy finder
    legendary-gl
    bitwig-studio5
    jdk17 # java
    libreoffice
    nitch # systhem fetch util
    nix-prefetch-github
    pipx # Install Python applications in isolated environments
    prismlauncher # minecraft launcher
    ripgrep # grep replacement
    toipe # typing test in the terminal
    nemo-with-extensions # file manager
    yazi # terminal file manager
    yt-dlp
    (yabridge.override { wine = pkgs.wineWowPackages.stable; })
    yabridgectl
    ardour
    zenity
    steam-run
    # C / C++
    gcc
    gnumake
    # zed code editor
    zed-editor
    # language servers
    nixd
    rust-analyzer
    nodePackages.typescript-language-server
    nixfmt-rfc-style
    # Python
    python3
    figlet
    bleachbit # cache cleaner
    cmatrix
    gparted # partition manager
    ffmpeg
    imv # image viewer
    libnotify
    man-pages # extra man pages
    mpv # video player
    ncdu # disk space
    openssl
    pamixer # pulseaudio command line mixer
    pavucontrol # pulseaudio volume controle (GUI)
    playerctl # controller for media players
    unzip
    wget
    xdg-utils
  ];
}
