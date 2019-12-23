# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/mccurdyc/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/Users/mccurdyc/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/mccurdyc/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/mccurdyc/.fzf/shell/key-bindings.zsh"
