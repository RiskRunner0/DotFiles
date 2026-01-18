{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "Matt Smith";
    userEmail = "matthew.j.smith2@outlook.com";
  };
}
