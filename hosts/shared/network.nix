{pkgs, ...}: {
  networking = {
    networkmanager.enable = true;
    nameservers = ["1.1.1.1"];
  };

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];
}
