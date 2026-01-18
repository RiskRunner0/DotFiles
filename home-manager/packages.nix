{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    bat
    delta
    gcc
    # ghostty  # Installed via system package manager for OpenGL support
    obsidian
    ruby
    spotify
  ];
}
