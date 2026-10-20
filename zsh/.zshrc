# Portable interactive Zsh configuration.
[[ -o interactive ]] || return

export EDITOR="${EDITOR:-nvim}"
export VISUAL="${VISUAL:-$EDITOR}"
export HISTFILE="${HISTFILE:-$HOME/.zsh_history}"
export HISTSIZE=10000
export SAVEHIST=10000

setopt append_history
setopt hist_ignore_dups
setopt hist_reduce_blanks
setopt share_history
setopt auto_cd

autoload -Uz compinit && compinit
bindkey -e

alias ..='cd ..'
alias ...='cd ../..'
alias vim='nvim'
alias v='nvim'
alias gst='git status --short --branch'
alias gl='git log --oneline --decorate --graph'

if command -v eza >/dev/null 2>&1; then
  alias ls='eza --group-directories-first'
  alias ll='eza --long --all --git --group-directories-first'
  alias lt='eza --tree --level=2 --group-directories-first'
fi

# fd and rg are the default file/content search tools.
if command -v fd >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"
command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"

[[ -r "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
