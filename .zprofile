#!/bin/bash

# Autostart X at login
# if you don't have this, i3 won't be started
# https://wiki.archlinux.org/index.php/Xinit
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi

# Load .bashrc and other files...
for file in ~/.{zshrc,zsh_prompt,aliases,functions,path,gofunc,dockerfunc,gitfunc,exports}; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		# shellcheck source=/dev/null
		source "$file"
	fi
done
unset file
