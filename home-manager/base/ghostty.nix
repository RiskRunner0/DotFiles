{ config, pkgs, ... }:
{
  xdg.configFile."ghostty/config".text = ''
    theme = Rose Pine Dawn

    # Exact blur intensity is ignored on KDE Plasma, it's the same as setting
    # "true" for any value, per the docs.
    background-blur = true

    # Set default shell to fish
    command = ${pkgs.fish}/bin/fish --login --interactive

    # Keybind Quick Terminal to Ctrl + `
    keybind = ctrl+grave_accent=toggle_quick_terminal
  '';
}
