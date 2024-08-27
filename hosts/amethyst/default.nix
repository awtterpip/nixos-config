{pkgs, ...}: {
  imports = [(import ./../shared/amd.nix) (import ./hardware-configuration.nix)];
  networking.hostName = "amethyst";
  # openrgb
  services.hardware.openrgb.enable = true;
  environment.systemPackages = with pkgs; [openrgb-with-all-plugins];
}
