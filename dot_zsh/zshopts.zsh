# Shell options

HISTSIZE=50000
SAVEHIST=50000

# Oh my ZSH enables shared history, but I don't like it.
unsetopt share_history

# Turn off autocomplete beeps
unsetopt listbeep

# Do not process each pasted character as a self-insert. Otherwise paste is slow.
# https://github.com/zsh-users/zsh-syntax-highlighting/issues/295#issuecomment-214581607
zstyle ':bracketed-paste-magic' active-widgets '.self-*'

# End of partial line (return symbol on red background)
PROMPT_EOL_MARK=$'%K{red}\u23ce %k'

# Remove duplicates
typeset -U path
typeset -U fpath

