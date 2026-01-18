{ config, pkgs, lib, ... }:

let
  personalExists = builtins.pathExists ./personal;
  workExists = builtins.pathExists ./work;
in
{
  # Home Manager needs a bit of information about you and the paths it should
   # manage.
  home.username = "matt";
  home.homeDirectory = "/home/matt";
  home.stateVersion = "24.11";

  xdg.enable = true;
  targets.genericLinux.enable = true;
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./base
    ./packages.nix
  ] ++ lib.optionals personalExists [ ./personal ]
  ++ lib.optionals workExists [ ./work ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
