{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Matt Smith";
        email = "matthew.j.smith2@outlook.com";
      };
    };
  };
}
