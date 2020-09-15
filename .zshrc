if [[ "$ZPROF" = true ]]; then
  zmodload zsh/zprof
fi

# purpose; zsh shell config; well integrated with vim and tmux.
## warning; zsh aliases require double quotes; bash aliases do not.

#!/bin/bash

# Autostart X at login
# if you don't have this, i3 won't be started
# https://wiki.archlinux.org/index.php/Xinit
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi

# Load files...
for file in ~/.{zsh_prompt,aliases,aliases_work,fzf.zsh,functions,path,gitfunc,exports,exports_work}; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		# shellcheck source=/dev/null
		source "$file"
	fi
done
unset file

# clobber "file exists" warning
# clobber is toggled off below
setopt clobber

# Don't write duplicates to history.
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt extendedglob
# Don't wait to write to history.
setopt inc_append_history
setopt share_history

# autocomplete
setopt COMPLETE_ALIASES
autoload -Uz compinit && compinit -i

# Configure the shell so that it uses kj for escape
bindkey -M viins 'kj' vi-cmd-mode

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

# store prompt command
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'

# https://docs.chef.io/workstation/workstation_setup/
# THIS IS SLOW!!!!!!
# eval "$(chef shell-init zsh)"

# This is neccessary for fzf key-bindings to work
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/mccurdyc/oss/google-cloud-sdk/path.zsh.inc' ]; then . '/home/mccurdyc/oss/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/mccurdyc/oss/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/mccurdyc/oss/google-cloud-sdk/completion.zsh.inc'; fi

# This has to be sourced late
source $HOME/.zsh/plugins/Aloxaf/fzf-tab/fzf-tab.plugin.zsh

eval "$(hub alias -s)"

eval "$(fastly --completion-script-zsh)"

# asdf
source /opt/asdf-vm/asdf.sh

if [[ "$ZPROF" = true ]]; then
  zprof
fi
