## purpose; zsh shell config; well integrated with vim and tmux.
## warning; zsh aliases require double quotes; bash aliases do not.

#!/bin/bash

# Autostart X at login
# if you don't have this, i3 won't be started
# https://wiki.archlinux.org/index.php/Xinit
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi

# Load .bashrc and other files...
for file in ~/.{zsh_prompt,aliases,functions,path,gofunc,dockerfunc,gitfunc,exports}; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		# shellcheck source=/dev/null
		source "$file"
	fi
done
unset file

# clobber "file exists" warning
# clobber is toggled off below
setopt clobber
# Open new terminal in same directory as last terminal:
if [ -f ~/.last_dir ]; then
	cd "`cat ~/.last_dir`"
fi

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
# unsetopt CLOBBER  ## require >| to truncate
REPORTTIME=2      ## stats if cmd takes >2sec

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# store prompt command
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"
