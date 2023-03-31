# Color related tweaks

# In the linux tty grey is white and it is impossible to differentiate suggestions from commands :(
[[ "$TERM" == linux ]] && ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=black,bold'

ZSH_HIGHLIGHT_STYLES[comment]='fg=cyan'

