{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      # LSPs
      nil
      lua-language-server
      typescript-language-server
      pyright

      # Formatters
      nixpkgs-fmt
      stylua
      black

      # DAP
      delve

      # Tools
      ripgrep
      fd
      git
      nodejs
      python3

      # Clipboard support
      xclip
    ];
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.file.".config/nvim" = {
    source = /home/matt/workspace/DotFiles/nvim;
    recursive = true;
  };
}
