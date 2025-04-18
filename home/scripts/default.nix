{ pkgs, ... }:
let
  wall-change = pkgs.writeShellScriptBin "wall-change" ''swaybg -m fill -i $1'';
  wallpaper-picker = pkgs.writeShellScriptBin "wallpaper-picker" (
    builtins.readFile ./scripts/wallpaper-picker.sh
  );

  fix-steam = pkgs.writeShellScriptBin "fix-steam" (builtins.readFile ./scripts/fix-steam.sh);

  runbg = pkgs.writeShellScriptBin "runbg" (builtins.readFile ./scripts/runbg.sh);
  music = pkgs.writeShellScriptBin "music" (builtins.readFile ./scripts/music.sh);
  lofi = pkgs.writeScriptBin "lofi" (builtins.readFile ./scripts/lofi.sh);
  invincible = pkgs.writeScriptBin "invincible" (builtins.readFile ./scripts/invincible.sh);

  toggle_blur = pkgs.writeScriptBin "toggle_blur" (builtins.readFile ./scripts/toggle_blur.sh);
  toggle_oppacity = pkgs.writeScriptBin "toggle_oppacity" (
    builtins.readFile ./scripts/toggle_oppacity.sh
  );

  maxfetch = pkgs.writeScriptBin "maxfetch" (builtins.readFile ./scripts/maxfetch.sh);

  compress = pkgs.writeScriptBin "compress" (builtins.readFile ./scripts/compress.sh);
  extract = pkgs.writeScriptBin "extract" (builtins.readFile ./scripts/extract.sh);

  shutdown-script = pkgs.writeScriptBin "shutdown-script" (
    builtins.readFile ./scripts/shutdown-script.sh
  );

  show-keybinds = pkgs.writeScriptBin "show-keybinds" (builtins.readFile ./scripts/keybinds.sh);
in
{
  home.packages = [
    wall-change
    wallpaper-picker

    runbg
    music
    lofi
    invincible

    toggle_blur
    toggle_oppacity

    maxfetch

    fix-steam

    compress
    extract

    shutdown-script

    show-keybinds
  ];
}
