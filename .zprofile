#!/bin/bash

# Load .bashrc and other files...
for file in ~/.{zshrc,zprofile,zsh_prompt,aliases,functions,path,gofunc,dockerfunc,gitfunc,exports}; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		# shellcheck source=/dev/null
		source "$file"
	fi
done
unset file
