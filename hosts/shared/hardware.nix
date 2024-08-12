{
  pkgs,
  inputs,
  ...
}: {
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  hardware.graphics.package = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.mesa.drivers;
  hardware.enableRedistributableFirmware = true;
  hardware.opentabletdriver.enable = true;
  powerManagement.cpuFreqGovernor = "performance";
}
