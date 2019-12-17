# Setup fzf
# ---------
if [[ ! "$PATH" == */home/mccurdyc/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/mccurdyc/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/mccurdyc/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/mccurdyc/.fzf/shell/key-bindings.zsh"
