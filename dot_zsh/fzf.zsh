# Use this in place of ohmyzsh/ohmyzsh path:plugins/fzf so we can use our modified completion.zsh, key-bindings.zsh.

source "${0:A:h}/fzf/completion.zsh"
source "${0:A:h}/fzf/key-bindings.zsh"

if [[ -z "$FZF_DEFAULT_COMMAND" ]]; then
  if (( $+commands[fd] )); then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
  elif (( $+commands[rg] )); then
    export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*"'
  elif (( $+commands[ag] )); then
    export FZF_DEFAULT_COMMAND='ag -l --hidden -g "" --ignore .git'
  fi
fi
