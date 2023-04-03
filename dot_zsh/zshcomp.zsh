# zsh completion options

# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# trigger complete on empty prompt instead of inserting a tab
zstyle ':completion:*' insert-tab false

# git
zstyle ':completion:complete:git-*' sort false  # trust order of git completion

# processes
zstyle ':completion:*:*:*:*:processes' command 'ps -u $USERNAME -o pid,user,cmd -w -w'
