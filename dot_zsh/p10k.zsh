# Enable Powerlevel10k theme
# https://github.com/romkatv/powerlevel10k

if [[ "$TERM_PROGRAM" == "vscode" ]]; then
#  ITERM_SHELL_INTEGRATION_INSTALLED="Yes"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# # Get rid of the space on the right side of the right prompt.
# ZLE_RPROMPT_INDENT=0

# Enable shell integration for kitty
#typeset -g POWERLEVEL9K_TERM_SHELL_INTEGRATION=true


