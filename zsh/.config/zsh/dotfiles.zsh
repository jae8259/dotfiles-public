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

function y() {
  local tmp cwd
  tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  command yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [[ "$cwd" != "$PWD" && -d "$cwd" ]] && builtin cd -- "$cwd"
  command rm -f -- "$tmp"
}

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

zsh_plugin_dirs=("${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugins")
[[ -n "${CONDA_PREFIX:-}" ]] &&
  zsh_plugin_dirs=("$CONDA_PREFIX/share/zsh/plugins" "${zsh_plugin_dirs[@]}")

for zsh_plugin_dir in "${zsh_plugin_dirs[@]}"; do
  autosuggestions="$zsh_plugin_dir/zsh-autosuggestions/zsh-autosuggestions.zsh"
  if [[ -r "$autosuggestions" ]]; then
    source "$autosuggestions"
    break
  fi
done
unset autosuggestions

# Syntax highlighting must be loaded after other widgets and integrations.
for zsh_plugin_dir in "${zsh_plugin_dirs[@]}"; do
  syntax_highlighting="$zsh_plugin_dir/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  if [[ -r "$syntax_highlighting" ]]; then
    source "$syntax_highlighting"
    break
  fi
done
unset syntax_highlighting zsh_plugin_dir zsh_plugin_dirs
