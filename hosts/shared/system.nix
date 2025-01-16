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
    wivrn

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
    osu-lazer-bin
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
        wivrn = prev.wivrn.overrideAttrs (prev: {
          version = "0.22";

          src = pkgs.fetchFromGitHub {
            owner = "wivrn";
            repo = "wivrn";
            rev = "v0.22";
            hash = "sha256-i/CG+zD64cwnu0z1BRkRn7Wm67KszE+wZ5geeAvrvMY=";
          };

          nativeBuildInputs =
            with pkgs;
            [
              openssl
              glib
              makeWrapper
              qt6.full
              librsvg
              libnotify
            ]
            ++ prev.nativeBuildInputs;

          buildInputs =
            with pkgs;
            [
              openssl
              qt6.full
              libnotify
              librsvg
              glib
            ]
            ++ prev.buildInputs;

          monado = pkgs.applyPatches {
            src = pkgs.fetchFromGitLab {
              domain = "gitlab.freedesktop.org";
              owner = "monado";
              repo = "monado";
              rev = "aa2b0f9f1d638becd6bb9ca3c357ac2561a36b07";
              hash = "sha256-yfHtkMvX/gyVG0UgpSB6KjSDdCym6Reb9LRb3OortaI=";
            };

            patches = [
              "${final.wivrn.src}/patches/monado/0001-c-multi-early-wake-of-compositor.patch"
              "${final.wivrn.src}/patches/monado/0003-ipc-server-Always-listen-to-stdin.patch"
              "${final.wivrn.src}/patches/monado/0004-Use-extern-socket-fd.patch"
              "${final.wivrn.src}/patches/monado/0005-distortion-images.patch"
              "${final.wivrn.src}/patches/monado/0006-environment-blend-mode.patch"
              "${final.wivrn.src}/patches/monado/0008-Use-mipmaps-for-distortion-shader.patch"
              "${final.wivrn.src}/patches/monado/0009-convert-to-YCbCr-in-monado.patch"
              "${final.wivrn.src}/patches/monado/0010-d-solarxr-Add-SolarXR-WebSockets-driver.patch"
              "${final.wivrn.src}/patches/monado/0011-Revert-a-bindings-improve-reproducibility-of-binding.patch"
              "${final.wivrn.src}/patches/monado/0012-store-alpha-channel-in-layer-1.patch"
            ];
          };

          cmakeFlags = [
            (pkgs.lib.cmakeBool "WIVRN_USE_VAAPI" true)
            (pkgs.lib.cmakeBool "WIVRN_USE_X264" true)
            (pkgs.lib.cmakeBool "WIVRN_USE_VULKAN_ENCODE" true)
            (pkgs.lib.cmakeBool "WIVRN_USE_SYSTEMD" true)
            (pkgs.lib.cmakeBool "WIVRN_USE_PIPEWIRE" true)
            (pkgs.lib.cmakeBool "WIVRN_USE_PULSEAUDIO" true)
            (pkgs.lib.cmakeBool "WIVRN_BUILD_CLIENT" false)
            (pkgs.lib.cmakeBool "WIVRN_BUILD_DASHBOARD" true)
            (pkgs.lib.cmakeFeature "WIVRN_OPENXR_MANIFEST_TYPE" "absolute")
            (pkgs.lib.cmakeBool "FETCHCONTENT_FULLY_DISCONNECTED" true)
            (pkgs.lib.cmakeFeature "FETCHCONTENT_SOURCE_DIR_MONADO" "${final.wivrn.monado}")
          ];
        });
      })
    ];
    config.allowUnfree = true;
  };
  system.stateVersion = "23.11";
}
