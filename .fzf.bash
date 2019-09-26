# Setup fzf
# ---------
if [[ ! "$PATH" == */home/fran/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/fran/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/fran/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/fran/.fzf/shell/key-bindings.bash"
