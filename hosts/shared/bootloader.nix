{pkgs, ...}: {
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.systemd-boot.configurationLimit = 10;
    supportedFilesystems = ["bcachefs"];
    readOnlyNixStore = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };
}
