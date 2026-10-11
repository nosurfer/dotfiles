# Powerlevel10k instant prompt. Keep this close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

emulate -L zsh

# Locale.
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Paths.
typeset -U path
path=(
  "$HOME/.local/bin"
  "$HOME/bin"
  /usr/local/bin
  /usr/local/sbin
  /opt/homebrew/bin
  /opt/homebrew/sbin
  $path
)
export PATH

if command -v go >/dev/null 2>&1; then
  local_go_bin="$(go env GOPATH 2>/dev/null)/bin"
  [[ -n "$local_go_bin" ]] && path+=("$local_go_bin")
  export PATH
fi

# History.
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_DUPS SHARE_HISTORY APPEND_HISTORY

# Completion and navigation defaults without oh-my-zsh dependency.
autoload -Uz compinit bashcompinit
compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump"
setopt AUTO_CD INTERACTIVE_COMMENTS

# Prompt.
if [[ -r "$HOME/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
  typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=true
  source "$HOME/powerlevel10k/powerlevel10k.zsh-theme"
fi
[[ -r "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"

# Small shell niceties that you previously got from plugins.
autoload -Uz colors && colors
setopt PROMPT_SUBST

plugins=(git)

source $ZSH/oh-my-zsh.sh
source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme
plugins=(virtualenv)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status virtualenv)
#
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /opt/homebrew/opt/powerlevel10k/share/powerlevel10k/powerlevel10k.zsh-theme
source ~/.p10k.zsh
. "$HOME/.local/bin/env"


# ## ## ######################################################################################################
# proxy helpers
# ## ## ######################################################################################################
# _DOTFILES_PROXY_URL="http://192.168.139.3:10808"
#
# proxy() {
#   export http_proxy="$_DOTFILES_PROXY_URL"
#   export https_proxy="$_DOTFILES_PROXY_URL"
#   export all_proxy="$_DOTFILES_PROXY_URL"
#   export HTTP_PROXY="$_DOTFILES_PROXY_URL"
#   export HTTPS_PROXY="$_DOTFILES_PROXY_URL"
#   export ALL_PROXY="$_DOTFILES_PROXY_URL"
#   echo "Proxy mode enabled -> $_DOTFILES_PROXY_URL"
# }
#
# noproxy() {
#   unset http_proxy https_proxy all_proxy HTTP_PROXY HTTPS_PROXY ALL_PROXY NO_PROXY no_proxy
#   echo "Proxy mode disabled"
# }
#
# noproxy >/dev/null

export VIRTUAL_ENV_DISABLE_PROMPT=0

clear
export PATH="$HOME/.local/bin:$PATH"

# bind for jump keys
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

# end clear
clear

alias ls='ls --color=auto'
