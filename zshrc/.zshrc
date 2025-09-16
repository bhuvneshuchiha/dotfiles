# # export PATH=/usr/bin:$PATH
# # export PATH="$HOME/.local/scripts:$PATH"
# # # export ZSH=$HOME/.oh-my-zsh
# # PATH="$PATH":"$HOME/.local/scripts/"
# if [[ ":$PATH:" != *":$HOME/.local/scripts:"* ]]; then
#   export PATH="$HOME/.local/scripts:$PATH"
# fi
# export PATH="$HOME/.rbenv/bin:$PATH"
# eval "$(rbenv init -)"
# export EDITOR="nvim"
# export PATH="$(ruby -r rubygems -e 'puts Gem.bindir'):$PATH"
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
# # ZSH_THEME="powerlevel10k/powerlevel10k"
# ZSH_THEME="robbyrussell"
# plugins=(git)
# source <(fzf --zsh)
# # source $ZSH/oh-my-zsh.sh
# source /home/bhuvnesh-awasthi/.oh-my-zsh/oh-my-zsh.sh
# # history setup
# HISTFILE=$HOME/.zhistory
# SAVEHIST=1000
# HISTSIZE=999
# setopt share_history
# setopt hist_expire_dups_first
# setopt hist_ignore_dups
# setopt hist_verify
#
# # completion using arrow keys (based on history)
# bindkey '^[[A' history-search-backward
# bindkey '^[[B' history-search-forward
# # bindkey -s ^f "bash ~/.local/scripts/tmux-sessionizer\n"
# # bindkey -s ^f "tmux-sessionizer\n"
# bindkey -s ^f "tmux-sessionizer\n"
#
# # ---- Eza (better ls) -----
#
# alias ls="eza --icons=always"
# alias vim="nvim"
# # ---- Zoxide (better cd) ----
# eval "$(zoxide init zsh)"
# alias cd="z"
# alias kitt="kitten icat"
# # alias python='python3'
# # alias pip='pip3'
# # eval "$(starship init zsh)"
# bindkey -s "^G" "opencode\n"
# #terraform -install-autocomplete
#
# # source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#
# #THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
# # export SDKMAN_DIR="$HOME/.sdkman"
# # [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
# export PATH=$PATH:$HOME/go/bin
# # eval "$(/bin/brew shellenv)"
# # eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
#
# # bun completions
# [ -s "/home/bhuvnesh-awasthi/.bun/_bun" ] && source "/home/bhuvnesh-awasthi/.bun/_bun"
#
# # bun
# export BUN_INSTALL="$HOME/.bun"
# export PATH="$BUN_INSTALL/bin:$PATH"
# export PATH="$HOME/.bun/bin:$PATH"
#
# autoload -U +X bashcompinit && bashcompinit
# complete -o nospace -C /usr/bin/terraform terraform
# eval "$(~/.local/bin/mise activate)"


# PATH
export PATH="$HOME/.local/scripts:$HOME/.rbenv/bin:$HOME/go/bin:$HOME/.bun/bin:$PATH"
export EDITOR="nvim"

# rbenv (pick this OR rvm, not both)
eval "$(rbenv init -)"

# oh-my-zsh (minimal, only git plugin + lightweight theme)
ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git zsh-nvm)
source $ZSH/oh-my-zsh.sh

# fzf (use cached init)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zoxide
eval "$(zoxide init zsh)"

# bun
export BUN_INSTALL="$HOME/.bun"

# completion cache (faster startup)
autoload -Uz compinit
compinit -C

# history
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history hist_expire_dups_first hist_ignore_dups hist_verify

# keybinds
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
bindkey -s ^f "tmux-sessionizer\n"
bindkey -s "^G" "opencode\n"

# aliases
alias ls="eza --icons=always"
alias vim="nvim"
alias cd="z"
alias kitt="kitten icat"

