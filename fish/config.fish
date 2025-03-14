if status is-interactive
  # Commands to run in interactive sessions can go here

  # Add go bin to PATH
  set -x PATH ~/go/bin $PATH
  set -g fish_key_bindings fish_vi_key_bindings
end
