# GoLang set PATH
export GOPATH=$HOME/gocode
export PATH=$PATH:$GOPATH/bin

# vim powerline
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1

. /usr/local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh
. /usr/local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh
if [ -f ~/.local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh ]; then
        source ~/.local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh
    fi

# alias vim='vim --servername vim'

# Change the TERM environment variable (to get 256 colors) even if you are
# accessing your system through ssh and using either Tmux or GNU Screen:
if [ "$TERM" = "xterm" ] || [ "$TERM" = "xterm-256color" ]
then
    export TERM=xterm-256color
    export HAS_256_COLORS=yes
fi
if [ "$TERM" = "screen" ] && [ "$HAS_256_COLORS" = "yes" ]
then
    export TERM=screen-256color
fi

# current oracle java
export JAVA_HOME="$(/usr/libexec/java_home)"

# specific oracle java version
# export JAVA_HOME="$(/usr/libexec/java_home -v 1.8.0_31)"
# export JAVA_HOME="$(/usr/libexec/java_home -v 1.8.0_25)"
#export JAVA_HOME="$(/usr/libexec/java_home -v 1.8.0_45)"

export PATH=~/bin:$PATH
export PATH=$PATH:bin/apache-maven-3.3.9/bin

# Tex in El Capitan
export PATH=$PATH:/Library/TeX/Distributions/.DefaultTeX/Contents/Programs/texbin

export rvmsudo_secure_path=0

export PYTHONPATH=/usr/local/lib/python2.7/site-packages
export PYTHONSTARTUP=$HOME/.pythonrc.py

# Colorize the Terminal
export CLICOLOR=1;

stty stop undef

alias ll='ls -al'
alias cs='printf "\033c"'
alias gst='git status'

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

if [ -f $(brew --prefix)/etc/bash_completion.d/git-prompt.sh ]; then
  # PS1='\W$(__git_ps1 " (%s)")\$ '
  PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
fi

export PAGER=less
export LESS="-niSR"

export HISTFILESIZE=1000000
export HISTSIZE=1000000

# TODO.TXT alias
alias t='./todo.sh -d /Users/ColtonMcCurdy/Dropbox/todo/todo.cfg'

export TODOTXT_DEFAULT_ACTION=ls
alias t='./todo.sh -d /Users/ColtonMcCurdy/Dropbox/todo/todo.cfg'

# Add GHC 7.10.2 to the PATH, via https://ghcformacosx.github.io/
export GHC_DOT_APP="/Volumes/MacintoshHDD/mccurdyc/Downloads/ghc-7.10.2.app"
if [ -d "$GHC_DOT_APP" ]; then
    export PATH="${HOME}/.local/bin:${HOME}/.cabal/bin:${GHC_DOT_APP}/Contents/bin:${PATH}"
  fi

# eval $(boot2docker shellinit)

# alias magenta-weather="echo -e '\nmagenta weather running at: http://boot2docker:8081/\n'; \
#   docker run --hostname=boot2docker --rm -it --name=mw \
#   -v /Users/ColtonMcCurdy/magenta-weather:/home/deploy/app \
#   -p 8081:8080 thelearningegg/magenta-weather \
#   sh -c 'lein run'"

# -v /Users/ColtonMcCurdy/Sites/le/html-pdf-generator:/home/deploy/app \
# alias html-pdf-generator="echo -e '\nhtml pdf generator running at: http://boot2docker:8080/\n'; \
#   docker run --hostname=boot2docker --rm -it --name=generator \
#   -e WITHOUT_RABBIT=true \
#   -e BASE_URL=http://127.0.0.1:8080 \
#   -p 8080:8080  thelearningegg/html-pdf-generator"

export LGDEV="${HOME}/lg-dev"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export PS1='> '

