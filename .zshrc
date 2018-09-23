## purpose; zsh shell config; well integrated with vim and tmux.
## warning; zsh aliases require double quotes; bash aliases do not.

# autocomplete
setopt COMPLETE_ALIASES
autoload -Uz compinit
compinit

## etcetera
bindkey "^R" history-incremental-search-backward
bindkey -v        ## vim controls
setopt nobeep     ## prevent annoying beeps
setopt ignoreeof  ## prevent ctrl-d exits
setopt CHECK_JOBS ## warn about bg jobs
setopt autocd     ## mainly so ../ works
setopt nonomatch  ## prevent glob crashes
unsetopt CLOBBER  ## require >| to truncate
REPORTTIME=2      ## stats if cmd takes >2sec

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# base-16 colorscheme
# BASE16_SHELL=$HOME/.config/base16-shell/
# [ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
