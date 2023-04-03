# Use this in place of ohmyzsh/ohmyzsh path:plugins/fzf so we can use our modified completion.zsh, key-bindings.zsh.

# Enable if fzf is installed
type fzf &>/dev/null || return

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

# Further customizations

local fzf_binds=(
	"shift-left:preview-half-page-up"
	"shift-right:preview-half-page-down"
	"?:toggle-preview"
	"ctrl-/:change-preview-window\(right,62%\|down,62%\|hidden\)" # for some reason we need to escape "()|"" here
	"alt-z:toggle-preview-wrap"
	"backward-eof:abort"
)
# preview window with ~ goldenratio proportions
export FZF_DEFAULT_OPTS="--bind=${(j:,:)fzf_binds} --preview-window=right:62%:wrap --ansi"
[ "${TERM}" = linux ] && FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --no-unicode --color=16,border:bright-black" || true
unset fzf_binds
export FZF_CTRL_T_COMMAND="command find -L . -mindepth 1 \\( -path '*/\\.git' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
    -o -type f -print -o -type d -print -o -type l -print 2> /dev/null | cut -b3- | sort"
export FZF_CTRL_T_OPTS="--select-1 --exit-0 --preview 'less {}'"
export FZF_ALT_C_COMMAND="command find -L . -mindepth 1 \\( -path '*/\\.git' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
    -o -type d -print 2> /dev/null | cut -b3- | sort"
export FZF_ALT_C_OPTS="--select-1 --exit-0 --preview 'tree -C {} | head -200'"
export FZF_CTRL_R_OPTS=
# for ** completion
export FZF_COMPLETION_OPTS="--preview 'less {}'"
