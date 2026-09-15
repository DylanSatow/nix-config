# Portable fish config — hand-maintained twin of home/modules/shell.nix +
# theme.nix (the nix-generated file hardcodes /nix/store paths). Keep the two
# in sync when aliases/env change.

# Only execute this file once per shell.
set -q __fish_home_manager_config_sourced; and exit
set -g __fish_home_manager_config_sourced 1

# Environment (hm-session-vars equivalents)
set -gx EDITOR hx
set -gx VISUAL hx
set -gx STARSHIP_CONFIG ~/.config/starship.toml
set -gx GLAMOUR_STYLE ~/.config/glamour/catppuccin-mocha.json
# Point lazygit at the XDG config on every OS (its native mac path is
# ~/Library/Application Support/lazygit/config.yml).
set -gx LG_CONFIG_FILE ~/.config/lazygit/config.yml

# Homebrew on Apple Silicon (no-op elsewhere).
test -x /opt/homebrew/bin/brew; and /opt/homebrew/bin/brew shellenv | source
fish_add_path ~/.local/bin ~/.cargo/bin ~/go/bin

fish_config theme choose catppuccin-mocha

status is-interactive; and begin
    # Aliases (shared with .zshrc)
    alias cld 'claude --dangerously-skip-permissions'
    alias lg lazygit
    alias nv nvim
    alias vim nvim
    alias y yazi
    alias zj zellij
    alias zjd 'zellij delete-session'

    # Interactive shell initialisation
    command -q zoxide; and zoxide init fish | source

    if test "$TERM" != dumb; and command -q starship
        starship init fish | source
    end

    if command -q direnv; and not functions -q __direnv_export_eval
        direnv hook fish | source
    end
end
