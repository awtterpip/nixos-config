{...}: {
  imports = [(import ./../shared/amd.nix) (import ./hardware-configuration.nix)];
  networking.hostName = "amethyst";
}
