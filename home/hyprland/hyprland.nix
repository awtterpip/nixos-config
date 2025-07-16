{
  inputs,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    # swww
    swaybg
    grimblast
    hyprpicker
    wofi
    grim
    slurp
    wl-clipboard
    cliphist
    wf-recorder
    glib
    wayland
  ];
  systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland = {
      enable = true;
      # hidpi = true;
    };
    package = null;
    portalPackage = null;
    # enableNvidiaPatches = false;
    systemd.enable = true;
  };
}
