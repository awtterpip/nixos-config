{inputs, ...}: {
  imports =
    [(import ./hyprland.nix)]
    ++ [(import ./config.nix)]
    ++ [(import ./variables.nix)]
    ++ [inputs.hyprland.homeManagerModules.default inputs.catppuccin.homeManagerModules.catppuccin];
}
