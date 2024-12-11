{...}: {
  # programs.envision = {
  #   enable = true;
  #   openFirewall = true;
  # };
  programs.corectrl.enable = true;
  services.avahi = {
    enable = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };
}
