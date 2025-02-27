{pkgs, ...}: {
  networking = {
    networkmanager.enable = true;
    nameservers = ["1.1.1.1"];
    firewall.allowedTCPPorts = [
      25565
      9757
    ];
    firewall.allowedUDPPorts = [
      5353
      9757
    ];
  };

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];
}
