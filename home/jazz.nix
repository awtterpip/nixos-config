{ ... }:
{
  imports =
    [ (import ./audacious) ]
    ++ [ (import ./bat.nix) ]
    ++ [ (import ./btop.nix) ]
    ++ [ (import ./obs.nix) ]
    ++ [ (import ./dirs.nix) ]
    # ++ [(import ./cava)]
    ++ [ (import ./discord) ] # discord with catppuccin theme
    ++ [ (import ./floorp) ] # firefox based browser
    # ++ [(import ./gaming)]
    ++ [ (import ./git.nix) ]
    ++ [ (import ./direnv.nix) ]
    ++ [ (import ./gtk.nix) ]
    ++ [ (import ./hyprland) ]
    ++ [ (import ./kitty.nix) ]
    ++ [ (import ./mako.nix) ] # notification deamon
    # ++ [(import ./micro)] # nano replacement
    ++ [ (import ./nvim.nix) ]
    ++ [ (import ./packages.nix) ]
    # ++ [(import ./rider)] # C# JetBrain editor
    ++ [ (import ./scripts) ]
    # personal scripts
    ++ [ (import ./starship.nix) ]
    ++ [ (import ./swaylock.nix) ]
    # ++ [(import ./unity)]
    ++ [ (import ./vscodium.nix) ]
    ++ [ (import ./waybar) ]
    ++ [ (import ./wivrn.nix) ]
    ++ [ (import ./wofi) ]
    ++ [ (import ./zsh.nix) ]
    ++ [
      {
        catppuccin.enable = true;
        catppuccin.accent = "lavender";
      }
    ];
}
