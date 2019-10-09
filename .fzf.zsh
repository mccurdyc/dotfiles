# Setup fzf
# one "gotcha" is that brew installs to /usr/local/bin/fzf and aur installs to /usr/share/fzf

if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/usr/share/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/share/fzf/completion.zsh" 2> /dev/null

# Key bindings
# https://github.com/junegunn/fzf#key-bindings-for-command-line
# ------------
source "/usr/share/fzf/key-bindings.zsh"

# follow symbolic links, and don't want it to exclude hidden files
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
