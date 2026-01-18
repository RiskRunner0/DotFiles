{ config, pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    terminal = "screen-256color";
    historyLimit = 10000;
    mouse = true;
    keyMode = "vi";

    extraConfig = ''
      # Opens panes in current directory
      bind '"' split-window -v -c "#{pane_current_path}"
      bind '%' split-window -h -c "#{pane_current_path}"
    '';

    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      {
        plugin = rose-pine;
        extraConfig = ''
          set -g @rose_pine_variant 'dawn'
          set -g @rose_pine_host 'on'
          set -g @rose_pine_user 'on'
          set -g @rose_pine_directory 'on'
          set -g @rose_pine_bar_bg_disable 'on'
          set -g @rose_pine_bar_bg_disabled_color_option 'default'
          set -g @rose_pine_only_windows 'on'
          set -g @rose_pine_disable_active_window_menu 'on'
          set -g @rose_pine_default_window_behavior 'on'
          set -g @rose_pine_show_current_program 'on'
          set -g @rose_pine_show_pane_directory 'on'

          # Separators and icons
          set -g @rose_pine_left_separator ' > '
          set -g @rose_pine_right_separator ' < '
          set -g @rose_pine_field_separator ' | '
          set -g @rose_pine_window_separator ' - '
          set -g @rose_pine_hostname_icon '󰒋'
          set -g @rose_pine_date_time_icon '󰃰'
          set -g @rose_pine_window_status_separator "  "

          # Beta settings
          set -g @rose_pine_prioritize_windows 'on'
          set -g @rose_pine_width_to_hide '80'
          set -g @rose_pine_window_count '5'
        '';
      }
    ];
  };
}
