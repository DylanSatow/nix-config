# Portable zsh fallback — twin of the fish config for terminals that land in
# the system zsh. Mirrors home/modules/shell.nix (aliases, starship, zoxide,
# direnv, zjc/lg helpers) without oh-my-zsh.

export EDITOR=hx
export VISUAL=hx
export STARSHIP_CONFIG=~/.config/starship.toml
export GLAMOUR_STYLE=~/.config/glamour/catppuccin-mocha.json
export LG_CONFIG_FILE=~/.config/lazygit/config.yml

[[ -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
path=(~/.local/bin ~/.cargo/bin ~/go/bin $path)

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt HIST_FCNTL_LOCK HIST_IGNORE_DUPS HIST_IGNORE_SPACE SHARE_HISTORY

zjc() { zellij attach -c "${1:-unnamed_session}"; }

lg() {
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir
    command lazygit "$@"
    if [ -f "$LAZYGIT_NEW_DIR_FILE" ]; then
      cd "$(cat "$LAZYGIT_NEW_DIR_FILE")"
      rm -f "$LAZYGIT_NEW_DIR_FILE" > /dev/null
    fi
}

command -v zoxide >/dev/null && eval "$(zoxide init zsh)"
command -v direnv >/dev/null && eval "$(direnv hook zsh)"
if [[ $TERM != "dumb" ]] && command -v starship >/dev/null; then
  eval "$(starship init zsh)"
fi

alias cld='claude --dangerously-skip-permissions'
alias nv=nvim
alias vim=nvim
alias y=yazi
alias zj=zellij
alias zjd='zellij delete-session'
