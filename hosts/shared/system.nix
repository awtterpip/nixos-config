{ pkgs, ... }:
{
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://nix-gaming.cachix.org"
        "https://hyprland.cachix.org"
      ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  environment.systemPackages = with pkgs; [
    # command line tools
    wget
    unrar
    miniupnpc
    pkgsi686Linux.gperftools
    lzip
    alejandra
    git

    # system apps
    r2modman
    baobab
    krita
    rpcs3
    upnp-router-control
    lutris
    sunshine
    moonlight-qt
    unityhub
    chromium
    sidequest
    ncspot
    qpwgraph
    librepcb
    # game things
    wlx-overlay-s
    mangohud
  ];

  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";
  nixpkgs = {
    overlays = [
      (final: prev: {
        envision-unwrapped = prev.envision-unwrapped.overrideAttrs (prev: {
          version = "0-unstable-2024-09-03";
          buildInputs =
            with pkgs;
            [
              openxr-loader
            ]
            ++ prev.buildInputs;
          nativeBuildInputs =
            with pkgs;
            [
              git
              openxr-loader
            ]
            ++ prev.nativeBuildInputs;
          src = pkgs.fetchFromGitLab {
            owner = "gabmus";
            repo = "envision";
            rev = "b63b63efaf345b02658c88b0db72dff79f29de09";
            hash = "sha256-Edql69UN2v560c7lqDwuC8Jw2eYQyThFOh7JHzQ5n50=";
          };
          cargoDeps = pkgs.rustPlatform.importCargoLock {
            lockFile = ./envision/Cargo.lock;
            outputHashes = {
              "libmonado-rs-0.1.0" = "sha256-xztevBUaYBm5G3A0ZTb+3GV3g1IAU3SzfSS5BBqfp1Y=";
              "openxr-0.18.0" = "sha256-ktkbhmExstkNJDYM/HYOwAwv3acex7P9SP0KMAOKhQk=";
            };
          };
          postInstall = (prev.postInstall or "") + ''
            ln -s $out/share/applications/org.gabmus.envision.Devel.desktop $out/share/applications/org.gabmus.envision.desktop
            ln -s $out/share/metainfo/org.gabmus.envision.Devel.appdata.xml $out/share/metainfo/org.gabmus.envision.appdata.xml
          '';
        });
      })
    ];
    config.allowUnfree = true;
  };
  system.stateVersion = "23.11";
}
