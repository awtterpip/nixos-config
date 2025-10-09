{
  pkgs,
  inputs,
  ...
}:
{
  hardware.xpadneo.enable = true;
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  hardware.graphics.package =
    inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.mesa;
  hardware.bluetooth.enable = true;
  hardware.enableRedistributableFirmware = true;
  hardware.opentabletdriver.enable = true;
  powerManagement.cpuFreqGovernor = "performance";
}
