# User-local commands should take precedence when present.
if test -d "$HOME/.local/bin"
    fish_add_path --path "$HOME/.local/bin"
end

# Homebrew's Apple silicon prefix is not always present when Fish is launched
# directly by a terminal application.
if test (uname) = Darwin; and test -d /opt/homebrew/bin
    fish_add_path --path /opt/homebrew/bin /opt/homebrew/sbin
end

set -gx EDITOR nvim
set -gx VISUAL nvim

# Clipboard commands differ between macOS and Linux.
if test (uname) = Darwin
    alias clip='pbcopy'
else if type -q xclip
    alias clip='xclip -selection clipboard'
end

if type -q bat
    alias bcat='bat'
end

alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'

if status is-interactive
    fish_vi_key_bindings

    if type -q fzf
        if fzf --help | string match -q '*--fish*'
            fzf --fish | source
        else if type -q fzf_key_bindings
            fzf_key_bindings
        end
    end

    if type -q zoxide
        zoxide init fish | source
    end
end
