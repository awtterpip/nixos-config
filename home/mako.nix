{
  ...
}:
{
  services = {
    mako = {
      enable = true;
      settings = {
        font = "JetBrainsMono Nerd Font 12";
        padding = "15";
        defaultTimeout = 5000;
        borderSize = 2;
        borderRadius = 5;
        icons = true;
        actions = true;
      };
      extraConfig = ''
        text-alignment=center
      '';
    };
  };
}
