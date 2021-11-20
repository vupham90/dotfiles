export PS1="$ "

# Google Cloud keys
export GOOGLE_APPLICATION_CREDENTIALS="/Users/shopeevn/keys/investing-dev-a597264ff538.json"

# Strictly for work
export SP_UNIX_SOCKET=/tmp/spex.sock
export GOPRIVATE=git.garena.com

alias spexssh='socat -d -d -d UNIX-LISTEN:/tmp/spex.sock,reuseaddr,fork TCP:agent-tcp.spex.test.shopee.io:9299'
alias mysqllog='docker ps | grep mysql | grep -o "[a-z0-9]*" | xargs docker logs'
