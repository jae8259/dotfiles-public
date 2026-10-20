[[ -n "${DOTFILES_ZSH_LOADED:-}" ]] && return
typeset -g DOTFILES_ZSH_LOADED=1

export EDITOR="${EDITOR:-nvim}"
export VISUAL="${VISUAL:-$EDITOR}"
export HISTFILE="${HISTFILE:-$HOME/.zsh_history}"
export HISTSIZE="${HISTSIZE:-10000}"
export SAVEHIST="${SAVEHIST:-10000}"
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
export STARSHIP_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/starship.toml"
export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME:-$HOME/.config}/ripgrep/ripgreprc"

setopt append_history hist_ignore_dups hist_reduce_blanks share_history auto_cd
bindkey -e
autoload -Uz compinit
(( $+functions[compdef] )) || compinit

alias ..='cd ..'
alias ...='cd ../..'
alias vim='nvim'
alias v='nvim'

[[ -r "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliases_git.zsh" ]] &&
  source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliases_git.zsh"

if command -v eza >/dev/null 2>&1; then
  alias ls='eza --group-directories-first'
  alias l='eza --long --all --git --icons --group-directories-first'
  alias lt='eza --tree --level=2 --icons --git --group-directories-first'
fi

if command -v fd >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

if command -v fzf >/dev/null 2>&1; then
  fzf_init="$(fzf --zsh 2>/dev/null)" && eval "$fzf_init"
  unset fzf_init
fi

command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"
command -v atuin >/dev/null 2>&1 && eval "$(atuin init zsh)"
command -v tv >/dev/null 2>&1 && eval "$(tv init zsh)"
command -v mise >/dev/null 2>&1 && eval "$(mise activate zsh)"
command -v direnv >/dev/null 2>&1 && eval "$(direnv hook zsh)"

if [[ -n "${CONDA_PREFIX:-}" ]]; then
  autosuggestions="$CONDA_PREFIX/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
  [[ -r "$autosuggestions" ]] && source "$autosuggestions"
  unset autosuggestions

  # Syntax highlighting must be loaded after other widgets and integrations.
  syntax_highlighting="$CONDA_PREFIX/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  [[ -r "$syntax_highlighting" ]] && source "$syntax_highlighting"
  unset syntax_highlighting
fi
