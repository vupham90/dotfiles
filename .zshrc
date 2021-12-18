ZSHRC=$HOME/.zshrc
ZSHDIR=$(dirname $(realpath $ZSHRC))

export PS1="$ "

setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

source ${ZSHDIR}/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ${ZSHDIR}/zsh/zsh-fzf-history-search/zsh-fzf-history-search.zsh

# Increase key repeat rate
defaults write -g KeyRepeat -int 1

# Golang
export PATH="/usr/local/opt/go@1.16/bin:$PATH"
export PATH="$HOME/.go/bin:$PATH"
export GOPATH="$HOME/.go"
export GOMODCACHE=$HOME/.go/pkg/mod

# Google Cloud keys
export GOOGLE_APPLICATION_CREDENTIALS="/Users/shopeevn/keys/investing-dev-a597264ff538.json"

# Strictly for work
export GOPRIVATE=git.garena.com
export SP_UNIX_SOCKET=/tmp/spex.sock

alias spexssh='socat -d -d -d UNIX-LISTEN:/tmp/spex.sock,reuseaddr,fork TCP:agent-tcp.spex.test.shopee.io:9299'
alias mysqllog='docker ps | grep mysql | grep -o "[a-z0-9]*" | xargs docker logs'

export FZF_DEFAULT_OPTS='--height 20% --layout reverse --border vertical'
fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}
#zle -N fh fh
#bindkey '^R' fh
