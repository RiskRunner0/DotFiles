{ config, pkgs, ... }:
{
  programs = {
    fzf.enable = true;
    zoxide.enable = true;

    fish = {
      enable = true;

      shellInit = ''
        set -gx PATH "$HOME/.local/bin" $PATH
      '';

      interactiveShellInit = ''
        fish_vi_key_bindings
      '';

      shellAliases = {
        # Clipboard
        clip = "xclip -selection clipboard";
        cat = "bat";

        # Common shortcuts
        ll = "ls -la";
        la = "ls -A";
        l = "ls -CF";
      };

      plugins = [
        {
          name = "z";
          src = pkgs.fishPlugins.z.src;
        }
        {
          name = "fzf-fish";
          src = pkgs.fishPlugins.fzf-fish.src;
        }
      ];
    };
  };
}
