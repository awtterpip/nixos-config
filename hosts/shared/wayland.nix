{
  pkgs,
  inputs,
  ...
}: {
  programs.hyprland = {
    enable = true;
    # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  };
  xdg.portal.xdgOpenUsePortal = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
}
