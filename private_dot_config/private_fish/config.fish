set ABBR_TIPS_PROMPT "\e[1m{{ .abbr }}\e[0m => {{ .cmd }}"
set --universal nvm_default_packages pnpm
set --universal nvm_default_version latest

fish_add_path /home/marsh/.cargo/bin
fish_add_path /home/marsh/.rvm/bin
fish_add_path /home/marsh/.local/share/gem/ruby/3.0.0/bin

alias ssh="kitty +kitten ssh"

if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
    fish_vi_key_bindings
end

set -gx PNPM_HOME "/home/marsh/.local/share/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
