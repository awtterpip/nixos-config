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
    carla
    r2modman
    baobab
    krita
    rpcs3
    upnp-router-control
    lutris
    sunshine
    moonlight-qt
    chromium
    sidequest
    ncspot
    osu-lazer-bin
    qpwgraph
    cura-appimage
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
        cura-appimage = pkgs.stdenvNoCC.mkDerivation rec {
          pname = "cura-appimage";
          version = "5.9.0";

          # Give some good names so the intermediate packages are easy
          # to recognise by name in the Nix store.
          appimageBinName = "cura-appimage-tools-output";
          wrapperScriptName = "${pname}-wrapper-script";

          src = pkgs.fetchurl {
            url = "https://github.com/Ultimaker/Cura/releases/download/${version}/Ultimaker-Cura-${version}-linux-X64.AppImage";
            hash = "sha256-STtVeM4Zs+PVSRO3cI0LxnjRDhOxSlttZF+2RIXnAp4=";
          };

          appimageContents = pkgs.appimageTools.extract {
            inherit pname version src;
          };

          curaAppimageToolsWrapped = pkgs.appimageTools.wrapType2 {
            inherit src;
            # For `appimageTools.wrapType2`, `pname` determines the binary's name in `bin/`.
            pname = appimageBinName;
            inherit version;
            extraPkgs = _: [ ];
          };

          # The `QT_QPA_PLATFORM=xcb` fixes Wayland support, see https://github.com/NixOS/nixpkgs/issues/186570#issuecomment-2526277637
          # The `GTK_USE_PORTAL=1` fixes file dialog issues under Gnome, see https://github.com/NixOS/nixpkgs/pull/372614#issuecomment-2585663161
          script = pkgs.writeScriptBin wrapperScriptName ''
            #!${pkgs.stdenv.shell}
            # AppImage version of Cura loses current working directory and treats all paths relateive to $HOME.
            # So we convert each of the files passed as argument to an absolute path.
            # This fixes use cases like `cd /path/to/my/files; cura mymodel.stl anothermodel.stl`.

            args=()
            for a in "$@"; do
              if [ -e "$a" ]; then
                a="$(realpath "$a")"
              fi
              args+=("$a")
            done
            QT_QPA_PLATFORM=xcb GTK_USE_PORTAL=1 exec "${curaAppimageToolsWrapped}/bin/${appimageBinName}" "''${args[@]}"
          '';

          dontUnpack = true;

          nativeBuildInputs = [
            pkgs.copyDesktopItems
            pkgs.wrapGAppsHook3
          ];
          desktopItems = [
            # Based on upstream.
            # https://github.com/Ultimaker/Cura/blob/382b98e8b0c910fdf8b1509557ae8afab38f1817/packaging/AppImage/cura.desktop.jinja
            (pkgs.makeDesktopItem {
              name = "cura";
              desktopName = "UltiMaker Cura";
              genericName = "3D Printing Software";
              comment = meta.longDescription;
              exec = "cura";
              icon = "cura-icon";
              terminal = false;
              type = "Application";
              mimeTypes = [
                "model/stl"
                "application/vnd.ms-3mfdocument"
                "application/prs.wavefront-obj"
                "image/bmp"
                "image/gif"
                "image/jpeg"
                "image/png"
                "text/x-gcode"
                "application/x-amf"
                "application/x-ply"
                "application/x-ctm"
                "model/vnd.collada+xml"
                "model/gltf-binary"
                "model/gltf+json"
                "model/vnd.collada+xml+zip"
              ];
              categories = [ "Graphics" ];
              keywords = [
                "3D"
                "Printing"
              ];
            })
          ];

          installPhase = ''
            runHook preInstall

            mkdir -p $out/bin
            cp ${script}/bin/${wrapperScriptName} $out/bin/cura

            mkdir -p $out/share/applications $out/share/icons/hicolor/128x128/apps
            install -Dm644 ${appimageContents}/usr/share/icons/hicolor/128x128/apps/cura-icon.png $out/share/icons/hicolor/128x128/apps/cura-icon.png

            runHook postInstall
          '';

          passthru.updateScript = pkgs.nix-update-script { extraArgs = [ "--version-regex=([56789].+)" ]; };

          meta = {
            description = "3D printing software";
            homepage = "https://github.com/ultimaker/cura";
            changelog = "https://github.com/Ultimaker/Cura/releases/tag/${version}";
            longDescription = ''
              Cura converts 3D models into paths for a 3D printer. It prepares your print for maximum accuracy, minimum printing time and good reliability with many extra features that make your print come out great.
            '';
            license = pkgs.lib.licenses.lgpl3Plus;
            platforms = [ "x86_64-linux" ];
            mainProgram = "cura";
            maintainers = with pkgs.lib.maintainers; [
              pbek
              nh2
              fliegendewurst
            ];
          };
        };
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
