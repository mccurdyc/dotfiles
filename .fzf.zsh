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

# https://github.com/junegunn/fzf/wiki/Configuring-fuzzy-completion#dedicated-completion-key
# Instead of using TAB key with a trigger sequence (**<TAB>), you can assign a
# dedicated key for fuzzy completion while retaining the default behavior of TAB key.
export FZF_COMPLETION_TRIGGER=''
bindkey '^T' fzf-completion
bindkey '^I' $fzf_default_completion

# prefer to start in a tmux split pane
export FZF_TMUX=1
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"

export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
