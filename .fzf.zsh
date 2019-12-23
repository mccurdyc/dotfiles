# Setup fzf
# ---------
#
if [[ $OSTYPE == *"darwin"* ]]; then
  if [[ ! "$PATH" == */Users/mccurdyc/.fzf/bin* ]]; then
    export PATH="${PATH:+${PATH}:}/Users/mccurdyc/.fzf/bin"
  fi

  if [[ ! "$PATH" == */Users/mccurdyc/.fzf/shell* ]]; then
    [[ $- == *i* ]] && source "/Users/mccurdyc/.fzf/shell/completion.zsh" 2> /dev/null
    source "/Users/mccurdyc/.fzf/shell/key-bindings.zsh"
  fi
elif [[ $OSTYPE == *"linux"* ]]; then
  if [[ ! "$PATH" == */home/mccurdyc/.fzf/bin* ]]; then
    export PATH="${PATH:+${PATH}:}/home/mccurdyc/.fzf/bin"
  fi

  if [[ ! "$PATH" == */home/mccurdyc/.fzf/shell* ]]; then
    [[ $- == *i* ]] && source "/home/mccurdyc/.fzf/shell/completion.zsh" 2> /dev/null
    source "/home/mccurdyc/.fzf/shell/key-bindings.zsh"
  fi
fi
